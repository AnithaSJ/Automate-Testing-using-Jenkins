#Encoding: UTF-8
puts "Test: ÄÖÜäöüß\n"

puts "#{Time.new.strftime('%Y.%m.%d %H:%M:%S')} - START TESTING . . .\n"

require "./test_base_fw_VoC"

require "./test_case_fw_VoC_toolbox_module"



class TestExample

# Tested: 20180808
#=begin
  def test_issue_management_dashboard
    browse_to_new_project

    login_to_portal("username","Password")

    refresh_home_page



    @message = "'VoC - link Issue Management Dashboard' exists?"
    load_link_assert(@timeout_error_length, "link", "xpath", "//a[contains(@href, '/advancedFeedback/index')]")

    @message = "'VoC - link Issue Management Dashboard text=Issue Management Dashboard' exists?"
    ## TODO: failures
    load_link_assert(@timeout_error_length, "link", "xpath", "//a[contains(@href, '/advancedFeedback/index') and contains(text(),'BIssue Management Dashboard')]")





    browser = @@b
    xpath   = "//body//div[@class='row']//div[@id='sidebar']/div[@id='panel-org-tree']"

    @filter = CFilter.new(browser, xpath)



    puts @filter

    puts "--------------------------------------------------------------"



    puts "Filter Element                                = >#{@filter.getFilterElement}<"
    puts "Filter XPath                                  = >#{@filter.getFilterXPath}<"
    puts "Filter Sections                               = >#{@filter.getFilterSections}<"
    puts "Filter Sections Count                         = >#{@filter.getFilterSections.size}<"
    puts "Filter Sections XPath                         = >#{@filter.getFilterSectionsXPath}<"
    puts "Filter Section Panel Heading                  = >#{@filter.getFilterSectionPanelHeading}<"
    puts "Filter Section Panel Heading XPath            = >#{@filter.getFilterSectionPanelHeadingXPath}<"
    puts "Filter Section Panel Heading Text             = >#{@filter.getFilterSectionPanelHeadingText}<"
    puts "Filter Section Panel Tools                    = >#{@filter.getFilterSectionPanelTools}<"
    puts "Filter Section Panel Tools XPath              = >#{@filter.getFilterSectionPanelToolsXPath}<"
    puts "Filter Section Panel Tools Dropdowns          = >#{@filter.getFilterSectionPanelToolsDropdowns}<"
    puts "Filter Section Panel Tools Dropdowns Count    = >#{@filter.getFilterSectionPanelToolsDropdowns.size}<"
    puts "Filter Section Panel Tools Dropdowns XPath    = >#{@filter.getFilterSectionPanelToolsDropdownsXPath}<"

    #puts "Filter Section Panel Tools Button             = >#{@filter.getFilterSectionPanelToolsButton}<"
    #puts "Filter Section Panel Tools Button XPath       = >#{@filter.getFilterSectionPanelToolsButtonXPath}<"
    #puts "Filter Section Panel Tools Title              = >#{@filter.getFilterSectionPanelToolsTitle}<"

    puts "Filter Section Panel Tools Buttons            = >#{@filter.getFilterSectionPanelToolsButtons}<"
    puts "Filter Section Panel Tools Buttons Count      = >#{@filter.getFilterSectionPanelToolsButtons.size}<"
    puts "Filter Section Panel Tools Buttons XPath      = >#{@filter.getFilterSectionPanelToolsButtonsXPath}<"
    puts "Filter Section Panel Tools Titles             = >#{@filter.getFilterSectionPanelToolsTitles}<"
    puts "Filter Section Panel Tools Titles Count       = >#{@filter.getFilterSectionPanelToolsTitles.size}<"
    puts "Filter Section Panel Tools Titles Texts       = >#{@filter.getFilterSectionPanelToolsTitlesTexts}<"
    puts "Filter Section Panel Tools Titles Texts Count = >#{@filter.getFilterSectionPanelToolsTitlesTexts.size}<"

    puts "Filter Section Panel Body                     = >#{@filter.getFilterSectionPanelBody}<"
    puts "Filter Section Panel Body XPath               = >#{@filter.getFilterSectionPanelBodyXPath}<"
    puts "Filter Section Panel Body Period Picker       = >#{@filter.getFilterSectionPanelBodyPeriodPicker}<"
    puts "Filter Section Panel Body Period Picker XPath = >#{@filter.getFilterSectionPanelBodyPeriodPickerXPath}<"

    puts "Filter Section Panel Body Period Picker Dropdown       = >#{@filter.getFilterSectionPanelBodyPeriodPickerDropdown}<"
    puts "Filter Section Panel Body Period Picker Dropdown XPath = >#{@filter.getFilterSectionPanelBodyPeriodPickerDropdownXPath}<"

    puts "Filter Section Panel Body Period Picker Button         = >#{@filter.getFilterSectionPanelBodyPeriodPickerButton}<"
    puts "Filter Section Panel Body Period Picker Button XPath   = >#{@filter.getFilterSectionPanelBodyPeriodPickerButtonXPath}<"

    puts "Filter Section Panel Body Period Picker Menu           = >#{@filter.getFilterSectionPanelBodyPeriodPickerMenu}<"
    puts "Filter Section Panel Body Period Picker Menu XPath     = >#{@filter.getFilterSectionPanelBodyPeriodPickerMenuXPath}<"

    puts "Filter Section Panel Body Period Picker Menu Header           = >#{@filter.getFilterSectionPanelBodyPeriodPickerMenuHeader}<"
    puts "Filter Section Panel Body Period Picker Menu Header XPath     = >#{@filter.getFilterSectionPanelBodyPeriodPickerMenuHeaderXPath}<"

    sleep 10

    puts "Filter Section Panel Body Period Picker Menu Header Text      = >#{@filter.getFilterSectionPanelBodyPeriodPickerMenuHeaderText}<"

    puts "Filter Section Panel Body Period Picker Menu Body             = >#{@filter.getFilterSectionPanelBodyPeriodPickerMenuBody}<"
    puts "Filter Section Panel Body Period Picker Menu Body XPath       = >#{@filter.getFilterSectionPanelBodyPeriodPickerMenuBodyXPath}<"












    logout_from_portal

  end
#=end



# Tested: 20180808
#=begin
  def _test_voc_reporting_dashboard
    browse_to_new_project

    login_to_portal("ttr_support", "#F3nst3r")

    refresh_home_page



    @message = "'VoC - link VoC Reporting Dashboard' exists?"
    load_link_assert(@timeout_error_length, "link", "xpath", "//a[contains(@href, '/standardReporting/index')]")

    @message = "'VoC - link VoC Reporting Dashboard text=VoC Reporting Dashboard' exists?"
    ## TODO: failures
    load_link_assert(@timeout_error_length, "link", "xpath", "//a[contains(@href, '/standardReporting/index') and contains(text(),'VoCB Reporting Dashboard')]")



=begin
    browser = @@b
    xpath   = "//body/nav//div[@id='navbar']"

    @navbar = CNavBar.new(browser, xpath)



    puts @navbar

    puts "--------------------------------------------------------------"
=end



=begin
    @navbar.selectModuleByName('Issue Management Dashboard')



    puts "Navigation Bar Active Module    = >#{@navbar.getActiveModule}<"

    puts "--------------------------------------------------------------"



    @navbar.selectModuleByName('VoC Reporting Dashboard')



    puts "Navigation Bar Active Module    = >#{@navbar.getActiveModule}<"

    puts "--------------------------------------------------------------"
=end



    #start_timer_td = Time.now

    #@table.browser.div(:xpath, "//div[@id='feedbackDetailModal' and not(@class='modal fade')]").wait_until_present

    #end_timer_td = Time.now

    #puts "table detail - duration: #{end_timer_td - start_timer_td}"



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



    #puts "Navigation Bar XPath            = >#{@navbar.xpath}<"
    #puts "Navigation Bar Elements         = >#{@navbar.getNavBarElements}<"
    #puts "Navigation Bar Elements XPath   = >#{@navbar.getNavBarElementsXPath}<"
    #puts "Navigation Bar Modules          = >#{@navbar.getNavBarModules}<"
    #puts "Navigation Bar Modules XPath    = >#{@navbar.getNavBarModulesXPath}<"
    #puts "Navigation Bar Modules Contents = >#{@navbar.getNavBarModulesContents}<"
    #puts "Navigation Bar Active Module    = >#{@navbar.getActiveModule}<"
    #puts "Navigation Bar Right            = >#{@navbar.getNavBarRight}<"
    #puts "Navigation Bar Right XPath      = >#{@navbar.getNavBarRightXPath}<"
    #puts "Navigation Bar Right Contents   = >#{@navbar.getNavBarRightContents}<"



    puts "--------------------------------------------------------------"
    puts "\n"



=begin
    @navbar.selectModuleByName("Issue Management Dashboard")
    puts "Navigation Bar Active Module    = >#{@navbar.getActiveModule}<"

    @navbar.selectModuleByName("VoC Reporting Dashboard")
    puts "Navigation Bar Active Module    = >#{@navbar.getActiveModule}<"
=end



=begin
    @navbar.selectModuleByLink(@navbar.getNavBarModulesContents[0]["link"])
    puts "Navigation Bar Active Module    = >#{@navbar.getActiveModule}<"

    @navbar.selectModuleByLink(@navbar.getNavBarModulesContents[1]["link"])
    puts "Navigation Bar Active Module    = >#{@navbar.getActiveModule}<"
=end



=begin
    puts "Navigation Bar Active Language  = >#{@navbar.getActiveLanguage}<"



    language = @navbar.selectLanguageByName("English (GB)")
    puts "Navigation Bar Active Language  = >#{language}<"

    puts "Navigation Bar Active Language  = >#{@navbar.getActiveLanguage}<"
=end



=begin
    browser = @@b
    xpath   = "//div[@id='content-wrapper']/div/div[@id='feedback-table']/div[@id='feedback-table-panel']/div[contains(@class, 'panel-body')]/div[@id='adv-feedback-table']/table"

    @table = CTable.new(browser, xpath)



    puts @table

    puts "--------------------------------------------------------------"
=end



=begin
    org_unit   = "Nederlands"
    period     = "12 months rolling"
    year       = "2018"
    month      = "February"
    brand      = "BMW"
    touchpoint = "ALL"
    nps_groups = [ "Detractor", "Neutral", "Promoter" ]

    @filter = CFilter.new(browser, org_unit, period, year, month, brand, touchpoint)

    puts @filter

    puts "--------------------------------------------------------------"



    @filter.setOrgUnit(["Netherlands"])

    @filter.setPeriod("12 months rolling")

    @filter.setYear("2018")

    @filter.setMonth("February")

    @filter.setBrand("BMW")

    @filter.setNPS_groups([ "Detractor", "Neutral", "Promoter" ])
=end



    browser = @@b
    xpath   = "//body//div[@class='row']//div[@id='sidebar']/div[@id='panel-org-tree']"

    @filter = CFilter.new(browser, xpath)



    puts @filter

    puts "--------------------------------------------------------------"



    puts "Filter Element                     = >#{@filter.getFilterElement}<"
    puts "Filter XPath                       = >#{@filter.getFilterXPath}<"
    puts "Filter Sections                    = >#{@filter.getFilterSections}<"
    puts "Filter Sections Count              = >#{@filter.getFilterSections.size}<"
    puts "Filter Sections XPath              = >#{@filter.getFilterSectionsXPath}<"
    puts "Filter Section Panel Heading       = >#{@filter.getFilterSectionPanelHeading}<"
    puts "Filter Section Panel Heading XPath = >#{@filter.getFilterSectionPanelHeadingXPath}<"
    puts "Filter Section Panel Heading Text  = >#{@filter.getFilterSectionPanelHeadingText}<"
    puts "Filter Section Panel Tools         = >#{@filter.getFilterSectionPanelTools}<"
    puts "Filter Section Panel Tools XPath   = >#{@filter.getFilterSectionPanelToolsXPath}<"
    puts "Filter Section Panel Tools Button       = >#{@filter.getFilterSectionPanelToolsButton}<"
    puts "Filter Section Panel Tools Button XPath = >#{@filter.getFilterSectionPanelToolsButtonXPath}<"
    puts "Filter Section Panel Tools Title        = >#{@filter.getFilterSectionPanelToolsTitle}<"





























    browser = @@b
    xpath   = "//body//div[@class='row']//div[@id='sidebar']"

    @sidebar = CSideBar.new(browser, xpath)



    puts @sidebar

    puts "--------------------------------------------------------------"



    puts "Side Bar Element                     = >#{@sidebar.getSidebarElement}<"
    puts "Side Bar XPath                       = >#{@sidebar.getSidebarXPath}<"
    puts "Side Bar Sections                    = >#{@sidebar.getSidebarSections}<"
    puts "Side Bar Sections Count              = >#{@sidebar.getSidebarSections.size}<"
    puts "Side Bar Sections XPath              = >#{@sidebar.getSidebarSectionsXPath}<"
    puts "Side Bar Section IC                  = >#{@sidebar.getSidebarSectionInterviewCount}<"
    puts "Side Bar Section IC XPath            = >#{@sidebar.getSidebarSectionInterviewCountXPath}<"
    puts "Side Bar Section IC Count            = >#{@sidebar.getSidebarSectionInterviewCountCount}<"
    puts "Side Bar Section IC Text             = >#{@sidebar.getSidebarSectionInterviewCountText}<"
    puts "Side Bar Section Filter              = >#{@sidebar.getSidebarSectionFilter}<"
    puts "Side Bar Section Filter XPath        = >#{@sidebar.getSidebarSectionFilterXPath}<"
    puts "Side Bar Section Info Text           = >#{@sidebar.getSidebarSectionInfoText}<"
    puts "Side Bar Section Info Text XPath     = >#{@sidebar.getSidebarSectionInfoTextXPath}<"
    puts "Side Bar Section Info Text Title     = >#{@sidebar.getSidebarSectionInfoTextTitle}<"
    puts "Side Bar Section Info Text Text      = >#{@sidebar.getSidebarSectionInfoTextText}<"
    puts "Side Bar Section Excel Exports       = >#{@sidebar.getSidebarSectionExcelExports}<"
    puts "Side Bar Section Excel Exports XPath = >#{@sidebar.getSidebarSectionExcelExportsXPath}<"
    puts "Side Bar Section Excel Exports Title = >#{@sidebar.getSidebarSectionExcelExportsTitle}<"
    puts "Side Bar Section Excel Exports List  = >#{@sidebar.getSidebarSectionExcelExportsList}<"





    logout_from_portal

  end
#=end

end
