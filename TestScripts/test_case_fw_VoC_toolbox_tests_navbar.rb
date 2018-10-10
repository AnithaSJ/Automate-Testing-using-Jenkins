#Encoding: UTF-8
puts "Test: ÄÖÜäöüß\n"

puts "#{Time.new.strftime('%Y.%m.%d %H:%M:%S')} - START TESTING . . .\n"

require "./test_base_fw_VoC"

require "./test_case_fw_VoC_toolbox_module"

class TestExample



  def test_voc_navigation_bar

    browse_to_new_project

    login_to_portal("ttr_support", "#F3nst3r")

    refresh_home_page

    browser  = @@b

    @message = "'VoC - Navigation Dashboard' exists?"
    load_link_assert(@timeout_error_length, "div", "xpath", "//body/nav//div[@id='navbar']")

    xpath =   "//body/nav//div[@id='navbar']"
=begin
    list_Modules = ["Issue Management Dashboard",
                    "VoC Reporting Dashboard",
                    "Account Tool",
                    "Holiday Management",
                    "Action Assessment",
                    "VoC Details",
                    "Action Planning",
                    "Customer Board",
                    "Customer Board Management" ]

    puts "Navigation Bar Modules list"
=end
    @navbar = CNavBar.new(browser, xpath)

    list_Modules = []
    elems_navbar_modules = @navbar.getNavBarModulesContents
    elems_navbar_modules.each do |i|
      list_Modules.push (i["title"].to_str)
    end
    puts list_Modules
    puts "-------------------------------------------------" +"\n"

    list_Modules.each do |i|
      puts i + "\n"
    #  module_select = @navbar.selectModuleByName(i)
    #  waitLoading
      module_select = elems_navbar_modules.find { |mod| mod["title"].include? i.to_str }
      puts "-------------------------------------------------" +"\n"
      xpath_str = module_select["xpath"]
      browser.element(:xpath, xpath_str).click!
      sleep 5
    end


=begin
    module_select = elems_navbar_modules.find { |mod| mod["isActive"] == true }.next
    puts "Current Selected Module>"+ module_select["title"] +"<"

=end


  #  elems_navbar_modules_contents = []

  #  elems_navbar_modules = browser.lis(:xpath, xpath + "/ul")

  #  elems_navbar_modules.each_with_index do |mod,i|
  #    elems_navbar_modules_contents[i]["title"] = mod.link.attribute_value('href')
  #    elems_navbar_modules_contents[i]["href"]  = mod.link.text

  #    puts "module[#{i}] title: >#{mod.link.text}<"

  #    puts "module[#{i}] href:  >#{mod.link.attribute_value('href')}<"
#    end

list_Right = []
elems_navbar_right = @navbar.getNavBarRightContents
elems_navbar_right.each do |i|
  puts i
  list_Right.push (i["title"].to_str)
end

puts "-------------------------------------------------" +"\n"

list_Right.each do |i|
#  module_select = @navbar.selectModuleByName(i)
  module_select = elems_navbar_right.find { |mod| mod["title"].include? i.to_str }
  puts i + "\n"
  puts "-------------------------------------------------" +"\n"

  xpath_str = module_select["xpath"]
  browser.element(:xpath, xpath_str).click!

  sleep 5

end



logout_from_portal

  end
end
