#Encoding: UTF-8
puts "Test: ÄÖÜäöüß\n" 

puts "#{Time.new.strftime('%Y.%m.%d %H:%M:%S')} - START TESTING . . .\n"

require "./test_base_fw_VoC"

require "./test_case_fw_VoC_toolbox_module"



class TestExample

# Tested: 20180808 OK
#=begin
  def test_voc_navigation_bar
    browse_to_new_project

    login_to_portal("ttr_support", "#F3nst3r")

    refresh_home_page



    @message = "'VoC - link VoC Reporting Dashboard' exists?"
    load_link_assert(@timeout_error_length, "link", "xpath", "//a[contains(@href, '/standardReporting/index')]")

    @message = "'VoC - link VoC Reporting Dashboard text=VoC Reporting Dashboard' exists?"
    load_link_assert(@timeout_error_length, "link", "xpath", "//a[contains(@href, '/standardReporting/index') and contains(text(),'VoC Reporting Dashboard')]")
    
    
    
    browser = @@b
    xpath   = "//body/nav//div[@id='navbar']"

    @navbar = CNavBar.new(browser, xpath)

    
    
    puts @navbar
    
    puts "--------------------------------------------------------------"
    
    
    
    start_timer_td = Time.now
    
    #@table.browser.div(:xpath, "//div[@id='feedbackDetailModal' and not(@class='modal fade')]").wait_until_present         
    
    end_timer_td = Time.now
    
    puts "table detail - duration: #{end_timer_td - start_timer_td}"
    
    
    
    #xpath = "//div[@id='feedbackDetailModal']"
    
    #@interview_detail = CInterviewDetail.new(browser, xpath, @table)
    
    #puts @interview_detail
    
    puts "\n"
    puts "--------------------------------------------------------------"
    
    #puts "Body Title     = >#{@interview_detail.getBodyTitle}<"
    
    #puts "Footer Buttons = >#{@interview_detail.getFooterButtons}<"
    
    #@footer_buttons = @interview_detail.getFooterButtons
    
    #(0..@footer_buttons.size-1).each do |i|
    #  puts "Footer Button[#{i}] text = >#{@footer_buttons[i].text}<" 
    #end
    
    
    
    puts "Navigation Bar XPath            = >#{@navbar.xpath}<"
    puts "Navigation Bar Elements         = >#{@navbar.getNavBarElements}<"
    puts "Navigation Bar Elements XPath   = >#{@navbar.getNavBarElementsXPath}<"
    puts "Navigation Bar Modules          = >#{@navbar.getNavBarModules}<"
    puts "Navigation Bar Modules XPath    = >#{@navbar.getNavBarModulesXPath}<"
    puts "Navigation Bar Modules Contents = >#{@navbar.getNavBarModulesContents}<"
    puts "Navigation Bar Active Module    = >#{@navbar.getActiveModule}<"
    puts "Navigation Bar Right            = >#{@navbar.getNavBarRight}<"
    puts "Navigation Bar Right XPath      = >#{@navbar.getNavBarRightXPath}<"
    #puts "Navigation Bar Right Contents   = >#{@navbar.getNavBarRightContents}<"


    
    puts "--------------------------------------------------------------"
    puts "\n"



=begin
    @navbar.selectModuleByName("Issue Management Dashboard")
    puts "Navigation Bar Active Module    = >#{@navbar.getActiveModule}<"

    @navbar.selectModuleByName("VoC Reporting Dashboard")
    puts "Navigation Bar Active Module    = >#{@navbar.getActiveModule}<"

    @navbar.selectModuleByName("Account Tool")
    puts "Navigation Bar Active Module    = >#{@navbar.getActiveModule}<"

    @navbar.selectModuleByName("Holiday Management")
    puts "Navigation Bar Active Module    = >#{@navbar.getActiveModule}<"

    @navbar.selectModuleByName("Action Assessment")
    puts "Navigation Bar Active Module    = >#{@navbar.getActiveModule}<"

    @navbar.selectModuleByName("Action Planning")
    puts "Navigation Bar Active Module    = >#{@navbar.getActiveModule}<"

    @navbar.selectModuleByName("Customer Board")
    puts "Navigation Bar Active Module    = >#{@navbar.getActiveModule}<"

    @navbar.selectModuleByName("Issue Management Dashboard")
    puts "Navigation Bar Active Module    = >#{@navbar.getActiveModule}<"
=end



=begin
    @navbar.selectModuleByLink(@navbar.getNavBarModulesContents[0]["link"])
    puts "Navigation Bar Active Module    = >#{@navbar.getActiveModule}<"

    @navbar.selectModuleByLink(@navbar.getNavBarModulesContents[1]["link"])
    puts "Navigation Bar Active Module    = >#{@navbar.getActiveModule}<"

    @navbar.selectModuleByLink(@navbar.getNavBarModulesContents[2]["link"])
    puts "Navigation Bar Active Module    = >#{@navbar.getActiveModule}<"

    @navbar.selectModuleByLink(@navbar.getNavBarModulesContents[3]["link"])
    puts "Navigation Bar Active Module    = >#{@navbar.getActiveModule}<"

    @navbar.selectModuleByLink(@navbar.getNavBarModulesContents[4]["link"])
    puts "Navigation Bar Active Module    = >#{@navbar.getActiveModule}<"

    @navbar.selectModuleByLink(@navbar.getNavBarModulesContents[5]["link"])
    puts "Navigation Bar Active Module    = >#{@navbar.getActiveModule}<"

    @navbar.selectModuleByLink(@navbar.getNavBarModulesContents[6]["link"])
    puts "Navigation Bar Active Module    = >#{@navbar.getActiveModule}<"

    @navbar.selectModuleByLink(@navbar.getNavBarModulesContents[0]["link"])
    puts "Navigation Bar Active Module    = >#{@navbar.getActiveModule}<"
=end



    puts "Navigation Bar Active Language  = >#{@navbar.getActiveLanguage}<"



    language = @navbar.selectLanguageByName("Nederlands")
    puts "Navigation Bar Active Language  = >#{language}<"

    puts "Navigation Bar Active Language  = >#{@navbar.getActiveLanguage}<"



    language = @navbar.selectLanguageByName("Nederlands")
    puts "Navigation Bar Active Language  = >#{language}<"

    puts "Navigation Bar Active Language  = >#{@navbar.getActiveLanguage}<"



    language = @navbar.selectLanguageByName("Thai")
    puts "Navigation Bar Active Language  = >#{language}<"

    puts "Navigation Bar Active Language  = >#{@navbar.getActiveLanguage}<"



    language = @navbar.selectLanguageByName("Deutsch (CH)")
    puts "Navigation Bar Active Language  = >#{language}<"

    puts "Navigation Bar Active Language  = >#{@navbar.getActiveLanguage}<"



    language = @navbar.selectLanguageByName("Deutsch (CH)")
    puts "Navigation Bar Active Language  = >#{language}<"

    puts "Navigation Bar Active Language  = >#{@navbar.getActiveLanguage}<"



    language = @navbar.selectLanguageByName("English (GB)")
    puts "Navigation Bar Active Language  = >#{language}<"

    puts "Navigation Bar Active Language  = >#{@navbar.getActiveLanguage}<"



    browser = @@b
    xpath   = "//div[@id='content-wrapper']/div/div[@id='feedback-table']/div[@id='feedback-table-panel']/div[contains(@class, 'panel-body')]/div[@id='adv-feedback-table']/table"

    @table = CTable.new(browser, xpath)

    
    
    puts @table
    
    puts "--------------------------------------------------------------"



    xpath = "//div[@id='sidebar']/div[@id='interviewCount']/div[@id='interviewCount']/div[contains(@class, 'panel-heading')]"

    @panel_total_interviews = CPanel.new(browser, xpath, @table)
    
    puts @panel_total_interviews
    
    puts "--------------------------------------------------------------"
    
    
    
    xpath = "//div[@id='content-wrapper']/div/div[@id='filter-tiles']/div/div[1]/div/div[contains(@class, 'panel-heading')]"

    @panel_total_issues = CPanel.new(browser, xpath, @table)
    
    puts @panel_total_issues
        
    puts "--------------------------------------------------------------"
    
    
    
    xpath = "//div[@id='content-wrapper']/div/div[@id='filter-tiles']/div/div[2]/div/div[contains(@class, 'panel-heading')]"

    @panel_open_fu_requests = CPanel.new(browser, xpath, @table)
    
    puts @panel_open_fu_requests
    
    puts "--------------------------------------------------------------"
    
    
    
    xpath = "//div[@id='content-wrapper']/div/div[@id='filter-tiles']/div/div[3]/div/div[contains(@class, 'panel-heading')]"

    @panel_overdue_fu_calls = CPanel.new(browser, xpath, @table)
    
    puts @panel_overdue_fu_calls
    
    puts "--------------------------------------------------------------"
    
    
    
    xpath = "//div[@id='content-wrapper']/div/div[@id='filter-tiles']/div/div[4]/div/div[contains(@class, 'panel-heading')]"

    @panel_overdue_solution = CPanel.new(browser, xpath, @table)
    
    puts @panel_overdue_solution
    
    puts "--------------------------------------------------------------"
    
    
    
    xpath = "//div[@id='content-wrapper']/div/div[@id='filter-tiles']/div/div[5]/div/div[contains(@class, 'panel-heading')]"

    @panel_open_calls = CPanel.new(browser, xpath, @table)
    
    puts @panel_open_calls
    
    puts "--------------------------------------------------------------"
    
    
    
    xpath = "//div[@id='content-wrapper']/div/div[@id='filter-tiles']/div/div[6]/div/div[contains(@class, 'panel-heading')]"

    @panel_overdue_calls = CPanel.new(browser, xpath, @table)
    
    puts @panel_overdue_calls
    
    puts "--------------------------------------------------------------"
















    logout_from_portal

  end
#=end
  
end  
