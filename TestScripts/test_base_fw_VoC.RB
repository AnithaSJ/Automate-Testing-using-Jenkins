#Encoding: UTF-8
puts "Test: ÄÖÜäöüß\n"

require "rubygems"
gem "test-unit"
require "test/unit"
require "timeout"
require "watir"

require "./test_case_run_method"

require "rautomation"

# check arguments for browser or headless specification
ARGV.each { |arg|
    if arg.downcase.include? 'chrome'
      $browser = 'chrome'
    elsif arg.downcase.include? 'firefox'
      $browser = 'firefox'
    elsif arg.downcase.include? 'ff'
      $browser = 'firefox'
    elsif arg.downcase.include? 'ie'
      $browser = 'ie'
    elsif arg.downcase.include? 'headless'
      $headless = true
    end
}

module ErrorCollector

  def collecting_errors
    is_collecting = @is_collecting
    @is_collecting = true
    yield
  ensure
    @is_collecting = is_collecting
  end

  def raise( * )
    super
  rescue Test::Unit::AssertionFailedError
    #################################################
    puts "\n>>>Test::Unit::AssertionFailedError<<<\n"
    handle_error( :add_failure, $! )
  rescue StandardError, ScriptError
    ###########################################
    puts "\n>>>StandardError, ScriptError<<<\n"
    handle_error( :add_error, $! )
  end

  def handle_error( method, error )
    bck = error.backtrace
    puts "\nbck: #{bck}\n"
    bck.shift
    if @is_collecting
      #bck.slice!( 5, 2 )

      a = bck.slice!( 7, 2 )

      ####################################################
      puts "\nbck.slice!( 7, 2 ): #{a}\n"

      TestExample.failures << a

      ##########################################
      puts "\nerror.message: #{error.message}\n"

      send( method, error.message, bck )
    else
      Kernel.raise( error, error.message, error.backtrace )
    end
  end

end

class TestExample < Test::Unit::TestCase

  include ErrorCollector

  class << self

	  def startup
      @@browser = 'firefox' if $browser.nil?

      puts "Browser: #{@@browser}\n"

      # Website name
      @@site = 'https://www.google.com' if $site.nil?

      if $headless
        require 'headless'
        $headless = Headless.new
        $headless.start
      end

      time = Time.new

      if @@browser == 'chrome'
        @@b = Watir::Browser.new :chrome
      elsif @@browser == 'firefox'

        #Selenium::WebDriver::Firefox::Binary.path = "D:/Program Files (x86)/Mozilla Firefox/firefox.exe"
        Selenium::WebDriver::Firefox::Binary.path = "C:/Program Files (x86)/Mozilla Firefox/firefox.exe"

        @@client = Selenium::WebDriver::Remote::Http::Default.new
        @@client.timeout = 120 # seconds
        puts "#{time.strftime('%Y.%m.%d %H:%M:%S')} - #{self.name}.#{__method__.to_s}: @@client.timeout = #{@@client.timeout}\n"
        #puts "#{time.strftime('%Y.%m.%d %H:%M:%S')} - #{self.to_s}.#{__method__.to_s}: @@client.timeout = #{@@client.timeout}\n"

        @@b = Watir::Browser.new :firefox, :http_client => @@client
        #@@b = Watir::Browser.new :ff

        @@b.driver.manage.timeouts.implicit_wait = 3
        @@b.driver.manage.timeouts.page_load = 30

      elsif @@browser == 'ie'

        @@client = Selenium::WebDriver::Remote::Http::Default.new
        @@client.timeout = 120 # seconds
        puts "#{time.strftime('%Y.%m.%d %H:%M:%S')} - #{self.name}.#{__method__.to_s}: @@client.timeout = #{@@client.timeout}\n"
        #puts "#{time.strftime('%Y.%m.%d %H:%M:%S')} - #{self.to_s}.#{__method__.to_s}: @@client.timeout = #{@@client.timeout}\n"

        @@b = Watir::Browser.new :ie, :http_client => @client
        #@@b = Watir::Browser.new :ie

        @@b.driver.manage.timeouts.implicit_wait = 3
        @@b.driver.manage.timeouts.page_load = 30
      end

      puts "#{time.strftime('%Y.%m.%d %H:%M:%S')} - #{self.name}.#{__method__.to_s}: @@browser = #{@@browser} --- @@b = #{@@b}\n"
      #puts "#{time.strftime('%Y.%m.%d %H:%M:%S')} - #{self.to_s}.#{__method__.to_s}: @@browser = #{@@browser} --- @@b = #{@@b}\n"

=begin
      File.open(File.dirname(__FILE__) + '/' + 'Results' + '/' + 'results.csv', 'a+'){|f|
        f << "Time;"
        f << "Method;"
        f << "Result;\n"
      }
=end

      @@failures = Array.new

    end

    def shutdown
      time = Time.new
      puts "#{time.strftime('%Y.%m.%d %H:%M:%S')} - #{self.name}.#{__method__.to_s}: @@browser = #{@@browser} --- @@b = #{@@b}\n"
      #puts "#{time.strftime('%Y.%m.%d %H:%M:%S')} - #{self.to_s}.#{__method__.to_s}: @@browser = #{@@browser} --- @@b = #{@@b}\n"

      @@b.close

      if $headless
        $headless.destroy
      end

      puts "\nNumber of Failures: #{@@failures.count}\n"

      if @@failures.count > 0
        puts "\nFailures:\n"
        @@failures.each { |failure| puts "#{failure}\n" }
      end

    end

    def failures
      @@failures
    end

  end

  def run(*args)
    result = super
    #time = Time.new
    #puts "#{time.strftime('%Y.%m.%d %H:%M:%S')} - #{self.class.name}.run: result = #{result}\n"
    #puts "#{time.strftime('%Y.%m.%d %H:%M:%S')} - #{self.class.name}.run: args = #{args}\n"
    #puts "#{time.strftime('%Y.%m.%d %H:%M:%S')} - #{self.class.to_s}.run: result = #{result}\n"
    #puts "#{time.strftime('%Y.%m.%d %H:%M:%S')} - #{self.class.to_s}.run: args = #{args}\n"
    result
  end

  # setup is run before every test
  def setup
    #@timeout_length = 30
    #@timeout_error_length = @timeout_length/3.0
    #@max_retries = 3
    #@timeout_length = 60
    #@timeout_error_length = @timeout_length/3.0
    #@max_retries = 3
    @timeout_length = 120
    @timeout_error_length = @timeout_length/6.0
    @max_retries = 6

    time = Time.new
    puts "#{time.strftime('%Y.%m.%d %H:%M:%S')} - #{self.class.name}.#{__method__.to_s}: @@browser = #{@@browser} --- @@b = #{@@b}\n"
    #puts "#{time.strftime('%Y.%m.%d %H:%M:%S')} - #{self.class.to_s}.#{__method__.to_s}: @@browser = #{@@browser} --- @@b = #{@@b}\n"

    @element = nil

    @load_link_message = "goto #{@@site}"
    load_link(@timeout_length){ @@b.goto @@site }
  end

  def cleanup
  end

  # teardown is run after every test
  def teardown
    time = Time.new

    if passed?
      puts "#{time.strftime('%Y.%m.%d %H:%M:%S')} - #{self.class.name}.#{__method__.to_s}: PASS\n"
      #puts "#{time.strftime('%Y.%m.%d %H:%M:%S')} - #{self.class.to_s}.#{__method__.to_s}: PASS\n"
    else
      puts "#{time.strftime('%Y.%m.%d %H:%M:%S')} - #{self.class.name}.#{__method__.to_s}: FAIL\n"
      #puts "#{time.strftime('%Y.%m.%d %H:%M:%S')} - #{self.class.to_s}.#{__method__.to_s}: FAIL\n"

      # take screenshot at end of test, useful for failures/errors
      #@@b.driver.save_screenshot(File.dirname(__FILE__) + '/Screenshots/' + @method_name + '_' + time.strftime('%Y%m%d_%H%M%S') + '.png');
      #@@b.driver.save_screenshot(File.dirname(__FILE__) + '/' + 'Screenshot' + '_' + self.inspect.to_s + '_' + time.strftime('%Y%m%d_%H%M%S') + '.png');
      #@@b.driver.save_screenshot(File.dirname(__FILE__) + '/' + 'Screenshot' + '_' + __callee__.to_s + '_' + time.strftime('%Y%m%d_%H%M%S') + '.png');
      #@@b.driver.save_screenshot(File.dirname(__FILE__) + '/' + 'Screenshot' + '_' + __method__.to_s + '_' + time.strftime('%Y%m%d_%H%M%S') + '.png');
      #@@b.driver.save_screenshot(File.dirname(__FILE__) + '/Screenshots/' + "[#{self.class.name}" + '#' + "#{__method__.to_s}]" + '_' + time.strftime('%Y%m%d_%H%M%S') + '.png');
      #@@b.driver.save_screenshot(File.dirname(__FILE__) + '/Screenshots/' + "[#{self.class.to_s}" + '#' + "#{__method__.to_s}]" + '_' + time.strftime('%Y%m%d_%H%M%S') + '.png');
      #time += 1
      #@@b.screenshot.save(File.dirname(__FILE__) + '/Screenshots/' + "[#{self.class.name}" + '#' + "#{__method__.to_s}]" + '_' + (Time.new + 1).strftime('%Y%m%d_%H%M%S') + '.png');
      #@@b.screenshot.save(File.dirname(__FILE__) + '/Screenshots/' + "[#{self.class.to_s}" + '#' + "#{__method__.to_s}]" + '_' + (Time.new + 1).strftime('%Y%m%d_%H%M%S') + '.png');

#=begin
      @@b.driver.save_screenshot(File.dirname(__FILE__) + '/Screenshots/' + "[#{self.class.name}" + '#' + "#{method_name}]" + '_' + time.strftime('%Y%m%d_%H%M%S') + '.png');
      #@@b.driver.save_screenshot(File.dirname(__FILE__) + '/Screenshots/' + "[#{self.class.to_s}" + '#' + "#{method_name}]" + '_' + time.strftime('%Y%m%d_%H%M%S') + '.png');
#=end

      #puts File.dirname(__FILE__) + '/' + 'Screenshot' + '_' + "[#{self.class.name}" + '#' + "#{__method__.to_s}]" + '_' + time.strftime('%Y%m%d_%H%M%S') + '.png\n'
      #puts File.dirname(__FILE__) + '/' + 'Screenshot' + '_' + "[#{self.class.to_s}" + '#' + "#{__method__.to_s}]" + '_' + time.strftime('%Y%m%d_%H%M%S') + '.png\n'
      puts "#{time.strftime('%Y.%m.%d %H:%M:%S')} - #{self.class.name}.teardown: Screenshot saved to " + File.dirname(__FILE__) + '/' + 'Screenshot' + '_' + "[#{self.class.name}" + '#' + "#{method_name}]" + '_' + time.strftime('%Y%m%d_%H%M%S') + '.png' + "\n"
      #puts "#{time.strftime('%Y.%m.%d %H:%M:%S')} - #{self.class.to_s}.teardown: Screenshot saved to " + File.dirname(__FILE__) + '/' + 'Screenshot' + '_' + "[#{self.class.to_s}" + '#' + "#{method_name}]" + '_' + time.strftime('%Y%m%d_%H%M%S') + '.png' + "\n"

      logout_from_portal
    end

    time = Time.new
    File.open(File.dirname(__FILE__) + '/' + 'Results' + '/' + 'results.csv', 'a+'){|f|
      f << time.strftime('%Y%m%d') + ";"
      f << time.strftime('%H%M%S') + ";"
      f << "#{self.class.to_s}" + '#' + "#{method_name}" + ";"
      f << (passed? ? ";" : "#{@message};")
      f << (passed? ? "PASS;" : "FAIL;")
      f << "\n"
    }
  end

  def browse_to_new_project
    @load_link_message = "browse to #{@@site}"
    load_link(@timeout_length){ @@b.goto @@site }
  end

  def refresh_home_page
    return if @@b.button(:xpath, "//div[@id='navbar']/ul[2]/li/div/button[@title='English (GB)']").exists?

    sleep 1

    @@b.button(:xpath, "//div[@id='navbar']/ul[2]/li/div/button").click

    sleep 1

    @@b.span(:xpath, "//div[@id='navbar']/ul[2]/li/div/div/ul/li/a/span").click

    sleep 5

    @@b.select(:xpath, "//div[@id='navbar']/ul[2]/li/div/select").select "English (GB)"

    sleep 5

    @load_link_message = "refresh home page #{@@site}/advancedFeedback/index"
    load_link(@timeout_length){ @@b.goto @@site + "/advancedFeedback/index" }
  end

  def login_to_portal(username = '******', password = '***********')
    @load_link_message = "login to portal"
    load_link(@timeout_length){
      @@b.text_field(:id => 'username').set username
      @@b.text_field(:id => 'password').set password

      @@b.button(:id => 'submit').click

      time = Time.new

      sleep 2
    }
  end

  def logout_from_portal
    @load_link_message = "logout from portal"
    load_link(@timeout_length){
      #@@b.link(:xpath => "//div[@id='navbar']/ul[2]/li[2]/a").click
      #@@b.link(:xpath => "//a[contains(text(),'Logout')]").click

      #@@b.link(:text => "Logout").click
      @@b.link(:xpath => "//form[@name='logout']/a").click

      sleep 1
    }
  end

  def load_link(waittime, print = true)
    begin
      Timeout::timeout(waittime) do
        time = Time.new
        puts "#{time.strftime('%Y.%m.%d %H:%M:%S')} - Timeout::timeout: " + @load_link_message + "\n" if print
        yield
      end
    rescue Timeout::Error => e
    time = Time.new
      if @element == nil
        puts "#{time.strftime('%Y.%m.%d %H:%M:%S')} - Timeout::Error occurred:\n #{e}\n"
      else
        #puts "#{time.strftime('%Y.%m.%d %H:%M:%S')} - Timeout::Error occurred:\n @element.tag_name = #{@element.tag_name}\n @element.text = #{@element.text}\n @element.html = #{@element.html}\n #{e}\n"
        puts "#{time.strftime('%Y.%m.%d %H:%M:%S')} - Timeout::Error occurred:\n #{e}\n"
      end
      retries ||= 0
      puts "#{time.strftime('%Y.%m.%d %H:%M:%S')} - Timeout::Error: retries = #{retries}\n"
      if retries < @max_retries
        retries += 1
        retry
      else
        puts "#{time.strftime('%Y.%m.%d %H:%M:%S')} - Timeout::Error: raise Timeout::Error\n"
        raise e
      end
    rescue Exception => e
      time = Time.new
      if @element == nil
        puts "#{time.strftime('%Y.%m.%d %H:%M:%S')} - Exception occurred:\n #{e}\n"
      else
        #puts "#{time.strftime('%Y.%m.%d %H:%M:%S')} - Exception occurred:\n @element.tag_name = #{@element.tag_name}\n @element.text = #{@element.text}\n @element.html = #{@element.html}\n #{e}\n"
        puts "#{time.strftime('%Y.%m.%d %H:%M:%S')} - Exception occurred:\n #{e}\n"
      end
      retries ||= 0
      puts "#{time.strftime('%Y.%m.%d %H:%M:%S')} - Exception: retries = #{retries}\n"
      if retries < @max_retries
        retries += 1
        time_to_wait = (Float(waittime) / @max_retries).round
        puts "#{time.strftime('%Y.%m.%d %H:%M:%S')} - Exception: time_to_wait = #{time_to_wait}\n"
        sleep time_to_wait
        retry
      else
        puts "#{time.strftime('%Y.%m.%d %H:%M:%S')} - Exception: raise Exception\n"
        raise e
      end
    rescue Selenium::WebDriver::Error::StaleElementReferenceError => e
      time = Time.new
      if @element == nil
        puts "#{time.strftime('%Y.%m.%d %H:%M:%S')} - Selenium::WebDriver::Error::StaleElementReferenceError occurred:\n #{e}\n"
      else
        #puts "#{time.strftime('%Y.%m.%d %H:%M:%S')} - Selenium::WebDriver::Error::StaleElementReferenceError occurred:\n @element.tag_name = #{@element.tag_name}\n @element.text = #{@element.text}\n @element.html = #{@element.html}\n #{e}\n"
        puts "#{time.strftime('%Y.%m.%d %H:%M:%S')} - Selenium::WebDriver::Error::StaleElementReferenceError occurred:\n #{e}\n"
      end
      retries ||= 0
      puts "#{time.strftime('%Y.%m.%d %H:%M:%S')} - Selenium::WebDriver::Error::StaleElementReferenceError: retries = #{retries}\n"
      if retries < @max_retries
        retries += 1
        retry
      else
        puts "#{time.strftime('%Y.%m.%d %H:%M:%S')} - Selenium::WebDriver::Error::StaleElementReferenceError: raise Error\n"
        raise e
      end
    rescue Selenium::WebDriver::Error::ElementNotVisibleError => e
      time = Time.new
      if @element == nil
        puts "#{time.strftime('%Y.%m.%d %H:%M:%S')} - Selenium::WebDriver::Error::ElementNotVisibleError occurred:\n #{e}\n"
      else
        #puts "#{time.strftime('%Y.%m.%d %H:%M:%S')} - Selenium::WebDriver::Error::ElementNotVisibleError occurred:\n @element.tag_name = #{@element.tag_name}\n @element.text = #{@element.text}\n @element.html = #{@element.html}\n #{e}\n"
        puts "#{time.strftime('%Y.%m.%d %H:%M:%S')} - Selenium::WebDriver::Error::ElementNotVisibleError occurred:\n #{e}\n"
      end
      retries ||= 0
      puts "#{time.strftime('%Y.%m.%d %H:%M:%S')} - Selenium::WebDriver::Error::ElementNotVisibleError: retries = #{retries}\n"
      if retries < @max_retries
        retries += 1
        time_to_wait = (Float(waittime) / @max_retries).round
        puts "#{time.strftime('%Y.%m.%d %H:%M:%S')} - Selenium::WebDriver::Error::ElementNotVisibleError: time_to_wait = #{time_to_wait}\n"
        sleep time_to_wait
        retry
      else
        puts "#{time.strftime('%Y.%m.%d %H:%M:%S')} - Selenium::WebDriver::Error::ElementNotVisibleError: raise Error\n"
        raise e
      end
    rescue Net::ReadTimeout => e
      time = Time.new
      if @element == nil
        puts "#{time.strftime('%Y.%m.%d %H:%M:%S')} - Net::ReadTimeout occurred:\n #{e}\n"
      else
        #puts "#{time.strftime('%Y.%m.%d %H:%M:%S')} - Net::ReadTimeout occurred:\n @element.tag_name = #{@element.tag_name}\n @element.text = #{@element.text}\n @element.html = #{@element.html}\n #{e}\n"
        puts "#{time.strftime('%Y.%m.%d %H:%M:%S')} - Net::ReadTimeout occurred:\n #{e}\n"
      end
      retries ||= 0
      puts "#{time.strftime('%Y.%m.%d %H:%M:%S')} - Net::ReadTimeout: retries = #{retries}\n"
      if retries < @max_retries
        retries += 1
        time_to_wait = (Float(waittime) / @max_retries).round
        puts "#{time.strftime('%Y.%m.%d %H:%M:%S')} - Net::ReadTimeout: time_to_wait = #{time_to_wait}\n"
        sleep time_to_wait
        retry
      else
        puts "#{time.strftime('%Y.%m.%d %H:%M:%S')} - Net::ReadTimeout: raise Error\n"
        raise e
      end
    rescue Error => e
      time = Time.new
      if @element == nil
        puts "#{time.strftime('%Y.%m.%d %H:%M:%S')} - Error occurred:\n #{e}\n"
      else
        #puts "#{time.strftime('%Y.%m.%d %H:%M:%S')} - Error occurred:\n @element.tag_name = #{@element.tag_name}\n @element.text = #{@element.text}\n @element.html = #{@element.html}\n #{e}\n"
        puts "#{time.strftime('%Y.%m.%d %H:%M:%S')} - Error occurred:\n #{e}\n"
      end
      retries ||= 0
      puts "#{time.strftime('%Y.%m.%d %H:%M:%S')} - Error: retries = #{retries}\n"
      if retries < @max_retries
        retries += 1
        retry
      else
        puts "#{time.strftime('%Y.%m.%d %H:%M:%S')} - Error: raise Error\n"
        raise e
      end
    end
  end

  def load_link_assert(waittime, tag, target, text)
    load_link(waittime, false){
      @element = eval("@@b." + tag + "(:" + target + " => \"" + text + "\")")
      assert_true @element.exists?, "Testing ... #{@element}"
    }
  end

  def load_link_assert_present(waittime, tag, target, text)
    load_link(waittime, false){
      @element = eval("@@b." + tag + "(:" + target + " => \"" + text + "\")")
      assert_true @element.present?
    }
  end

  def load_link_assert_visible(waittime, tag, target, text)
    load_link(waittime, false){
      @element = eval("@@b." + tag + "(:" + target + " => \"" + text + "\")")
      assert_true @element.visible?
    }
  end

  def load_link_assert_include_text(waittime, tag, target, text, text_included)
    load_link(waittime, false){
      @element = eval("@@b." + tag + "(:" + target + " => \"" + text + "\")")
      assert_true eval("@element.text.include?('" + text_included + "')")
    }
  end

  def load_link_wait_until_exist(waittime, tag1, target1, text1, tag2, target2, text2)
    load_link(waittime){
      @element1 = eval("@@b." + tag1 + "(:" + target1 + " => \"" + text1 + "\")")
      @element1.click
      @element2 = eval("@@b." + tag2 + "(:" + target2 + ", \"" + text2 + "\")")
      #@element2 = nil unless @element2.exists?
      @@b.wait_until{@element2.exists?}
    }
  end

  def load_link_wait_until_present(waittime, tag1, target1, text1, tag2, target2, text2)
    load_link(waittime){

      puts "\n"
      puts "@@b." + tag1 + "(:" + target1 + " => \"" + text1 + "\")"
      puts "\n"

      @element1 = eval("@@b." + tag1 + "(:" + target1 + " => \"" + text1 + "\")")

      puts "\n"
      puts @element1
      puts "\n"
      puts @element1.tag_name
      puts "\n"

      @element1.click

      puts "\n"
      puts "@@b." + tag2 + "(:" + target2 + " => \"" + text2 + "\")"
      puts "\n"

      @element2 = eval("@@b." + tag2 + "(:" + target2 + ", \"" + text2 + "\")")

      puts "\n"
      puts @element2
      puts "\n"
      puts @element2.tag_name
      puts "\n"

      #@element2 = nil unless @element2.present?
      @element2.wait_until_present
    }
  end

  def load_link_wait_until_exist_after_select(waittime, tag1, target1, text1, text_selected, tag2, target2, text2)
    load_link(waittime){
      @element1 = eval("@@b." + tag1 + "(:" + target1 + " => \"" + text1 + "\")")
      @element1.select text_selected
      @element2 = eval("@@b." + tag2 + "(:" + target2 + ", \"" + text2 + "\")")
      #@element2 = nil unless @element2.exists?
      @@b.wait_until{@element2.exists?}
    }
  end

  def write_result_to_file
    time = Time.new
    File.open(File.dirname(__FILE__) + '/' + 'Results' + '/' + 'results.csv', 'a+'){|f|
      f << time.strftime('%Y%m%d') + ";"
      f << time.strftime('%H%M%S') + ";"
      f << "#{self.class.to_s}" + '#' + "#{method_name}" + ";"
      f << "#{@message}" + ";"
      f << (passed? ? "PASS;" : "FAIL;")
      f << "\n"
    }
  end

=begin
  def assert_true(actual, message = nil)
    assert actual == true, message + "#{actual} should be true!"
  end
=end

  def assert_true(actual, message = nil)
    _wrap_assertion do
      if @element == nil
        full_message = build_message(message, "<?> should be true!", actual)
      else
        if @element.exists?
          full_message = build_message("Element:\n @element.tag_name = #{@element.tag_name}\n @element.text = #{@element.text}\n @element.html = #{@element.html}\n " + message.to_s, "<?> should be true!", actual)
        else
          full_message = build_message(message.to_s, "<?> should be true!", actual)
        end
      end
      #assert_block(build_message(message, "<?> should be true!", actual)) do
      assert_block(full_message) do
        actual == true
      end
      time = Time.new
      puts "#{time.strftime('%Y.%m.%d %H:%M:%S')} - assert_true: #{@message} ---> " + (passed? ? "PASS" : "FAIL") + "\n"
      write_result_to_file
    end
  end

  def assert_false(actual, message = nil)
    _wrap_assertion do
      if @element == nil
        full_message = build_message(message, "<?> should be false!", actual)
      else
        full_message = build_message("Element:\n @element.tag_name = #{@element.tag_name}\n @element.text = #{@element.text}\n @element.html = #{@element.html}\n " + message.to_s, "<?> should be false!", actual)
      end
      #assert_block(build_message(message, "<?> should be false!", actual)) do
      assert_block(full_message) do
        actual == false
      end
      time = Time.new
      puts "#{time.strftime('%Y.%m.%d %H:%M:%S')} - assert_false: #{@message} ---> " + (passed? ? "PASS" : "FAIL") + "\n"
      write_result_to_file
    end
  end

  def getCurrentQuarter
    quarter = case Time.new.month
      when  1 .. 3 then 1
      when  4 .. 6 then 2
      when  7 .. 9 then 3
      when 10 ..12 then 4
    end
  end



  # Methods used for RAutomation
  def load_window(waittime, window)
    begin
      Timeout::timeout(waittime) do
        time = Time.new
        yield
      end
    rescue Exception => e
      time = Time.new
      if window.exists?
        puts "#{time.strftime('%Y.%m.%d %H:%M:%S')} - Exception occurred:\n window.title = #{window.title}\n #{e}\n"
      else
        puts "#{time.strftime('%Y.%m.%d %H:%M:%S')} - Exception occurred:\n #{e}\n"
      end
      retries ||= 0
      puts "#{time.strftime('%Y.%m.%d %H:%M:%S')} - Exception: retries = #{retries}\n"
      if retries < @max_retries
        retries += 1
        time_to_wait = (Float(waittime) / @max_retries).round
        puts "#{time.strftime('%Y.%m.%d %H:%M:%S')} - Exception: time_to_wait = #{time_to_wait}\n"
        sleep time_to_wait
        retry
      else
        puts "#{time.strftime('%Y.%m.%d %H:%M:%S')} - Exception: raise Exception\n"
        raise e
      end
    end
  end

  def load_window_assert(waittime, window)
    load_window(waittime, window){
      assert_window_true window
      sleep 1
    }
  end

  def assert_window_true(window)
    _wrap_assertion do
      if window.exists?
        #full_message = build_message("Window:\n window.title = #{window.title}\n " + @message, "<?> should be true!", window.exists?)
        full_message = build_message("Window:\n window.hwnd = #{window.hwnd}\n " + @message, "<?> should be true!", window.exists?)
      else
        full_message = build_message(@message, "<?> should be true!", window.exists?)
      end
      assert_block(full_message) do
        window.exists? == true
      end
      time = Time.new
      puts "#{time.strftime('%Y.%m.%d %H:%M:%S')} - assert_true: #{@message} ---> " + (passed? ? "PASS" : "FAIL") + "\n"
      write_result_to_file
    end
  end

end
