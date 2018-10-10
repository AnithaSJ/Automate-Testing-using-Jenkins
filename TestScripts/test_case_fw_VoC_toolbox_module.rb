#Encoding: UTF-8
puts "Test: ÄÖÜäöüß\n"

require 'nokogiri'
require 'open-uri'

#require "./test_base_fw"
require "./test_base_fw_VoC"



# Tested: 20180808 OK
class CNavBar

  attr_reader :browser, :xpath, :elem_navbar
  #attr_writer :browser, :xpath, :elem_navbar



  def waitLoading
    puts "Loading data ..."

    self.browser.div(:xpath => "//div[@class='temp-container']/div[@class='placeholder-loader' and not (@id='interviewCount')]").wait_while_present
  end


  def initialize(browser, xpath = nil, elem_navbar = nil)
    @browser    = browser

    waitLoading

    @xpath      = xpath

    if xpath.nil?
      @elem_navbar = elem_navbar
    else
      @elem_navbar = @browser.div(:xpath, @xpath)
    end
  end



  def setBrowser(browser)
    self.browser = browser
  end



  def getNavBarElements
    return @elem_navbar.ul if @elem_navbar.ul.exists?
    return nil
  end



  def getNavBarElementsXPath
    return xpath + "/ul"
  end



  def getNavBarModules
    @elems_navbar_modules = @browser.lis(:xpath, getNavBarModulesXPath)
    return @elems_navbar_modules
  end



  def getNavBarModulesXPath
    return getNavBarElementsXPath + "[1]/li"
  end



  def getNavBarModulesContents
    @elems_navbar_modules_contents = []

    getNavBarModules.each_with_index do |mod, i|
      #puts "module[#{i}] class: >#{mod.attribute_value('class')}<"
      #puts "module[#{i}] xpath: >#{getNavBarModulesXPath + "[#{i+1}]/a"}<"
      #puts "module[#{i}] link:  >#{mod.link}<"
      #puts "module[#{i}] href:  >#{mod.link.attribute_value('href')}<"
      #puts "module[#{i}] title: >#{mod.link.text}<"

      #puts "--------------------------------------------------------------"
      #puts "\n"

      @elems_navbar_modules_contents[i] = {}

      @elems_navbar_modules_contents[i]["index"]    = i
      @elems_navbar_modules_contents[i]["isActive"] = mod.attribute_value('class') == "active"
      @elems_navbar_modules_contents[i]["xpath"]    = getNavBarModulesXPath + "[#{i+1}]/a"
      @elems_navbar_modules_contents[i]["link"]     = mod.link
      @elems_navbar_modules_contents[i]["href"]     = mod.link.attribute_value('href')
      @elems_navbar_modules_contents[i]["title"]    = mod.link.text
    end

    return @elems_navbar_modules_contents
  end



  def getActiveModule
    getNavBarModulesContents if @elems_navbar_modules_contents == [] or @elems_navbar_modules_contents.nil?

    return @elems_navbar_modules_contents.find { |mod| mod["isActive"] == true }
  end



  def selectModuleByName(name)
    getNavBarModulesContents if @elems_navbar_modules_contents == [] or @elems_navbar_modules_contents.nil?

    module_select = @elems_navbar_modules_contents.find { |mod| mod["title"].include? name }

    return module_select if module_select["isActive"] == true

    puts "Selecting module >#{name}<"

    module_select["link"].click

    puts module_select["link"]

    waitLoading

    return getNavBarModulesContents.find { |mod| mod["isActive"] == true }
  end



  def selectModuleByLink(link)
    getNavBarModulesContents if @elems_navbar_modules_contents == [] or @elems_navbar_modules_contents.nil?

    module_select = @elems_navbar_modules_contents.find { |mod| mod["link"] == link }

    return module_select if module_select["isActive"] == true

    puts "Selecting module >#{link}<"

    module_select["link"].click

    puts module_select["link"]

    waitLoading

    return getNavBarModulesContents.find { |mod| mod["isActive"] == true }
  end
=begin
  def selectNextModule

    list_Modules = ["Issue Management Dashboard",
                    "VoC Reporting Dashboard",
                    "Account Tool",
                    "Holiday Management",
                    "Action Assessment",
                    "VoC Details",
                    "Action Planning",
                    "Customer Board",
                    "Customer Board Management" ]

    getNavBarModulesContents if @elems_navbar_modules_contents == [] or @elems_navbar_modules_contents.nil?

    module_select = @elems_navbar_modules_contents.find { |mod| mod["isActive"] == true }.next
    puts "Current Selected Module>"+ module_select["title"] +"<"

    waitLoading

    return getNavBarModulesContents.find { |mod| mod["isActive"] == true }
  end
=end
  def getNavBarRight
    @elems_navbar_right = @browser.lis(:xpath, getNavBarRightXPath)
    return @elems_navbar_right
  end

  def getNavBarRightXPath
    return getNavBarElementsXPath + "[2]/li"
  end

  def getNavBarRightContents
    @elems_navbar_right_contents = []

    getNavBarRight.each_with_index do |mod, i|

      #puts "#{i}   #{mod.select(:id, 'lang-selection').exists?}"
      #puts "#{i}   #{mod.link(:href, '/move-voc/help/index').exists?}"
      #puts "#{i}   #{mod.a(:text, 'Help').exists?}"
      #puts "#{i}   #{mod.link(:href, '/move-voc/myAccount/index').exists?}"
      #puts "#{i}   #{mod.a(:text, 'My Account').exists?}"
      #puts "#{i}   #{mod.form(:name, 'logout').exists?}"
      #puts "----------------"

      #puts "#{i}   #{@browser.div(:xpath, getNavBarRightXPath + "[#{i+1}]/div").exists?}"
      #puts "#{i}   #{@browser.link(:xpath, getNavBarRightXPath + "[#{i+1}]/a").exists?}"
      #puts "#{i}   #{@browser.a(:xpath, getNavBarRightXPath + "[#{i+1}]/a").exists?}"
      #puts "#{i}   #{@browser.form(:xpath, getNavBarRightXPath + "[#{i+1}]/form").exists?}"
      #puts "----------------"

      if  #mod.select(:id, 'lang-selection').exists? or
          @browser.div(:xpath, getNavBarRightXPath + "[#{i+1}]/div").exists?

        type = :div

      elsif #mod.link(:href, '/move-voc/help/index').exists? or
            #mod.a(:text, 'Help').exists? or
            #mod.link(:href, '/move-voc/myAccount/index').exists? or
            #mod.a(:text, 'My Account').exists? or
            #@browser.link(:xpath, getNavBarRightXPath + "[#{i+1}]/a").exists? or
            @browser.a(:xpath, getNavBarRightXPath + "[#{i+1}]/a").exists?

        type = :link

      elsif #mod.form(:name, 'logout').exists? or
            @browser.form(:xpath, getNavBarRightXPath + "[#{i+1}]/form").exists?

        type = :form

      else

        type = :none

      end

      @elems_navbar_right_contents[i] = {}

      @elems_navbar_right_contents[i]["index"] = i

      case type
      when :div

        xpath_div = getNavBarRightXPath + "[#{i+1}]/div"
        @elems_navbar_right_contents[i]["xpath"]   = xpath_div
        @elems_navbar_right_contents[i]["button"]  = @browser.button(:xpath, xpath_div + "/button")
        @elems_navbar_right_contents[i]["data-id"] = @browser.button(:xpath, xpath_div + "/button").attribute_value('data-id')
        @elems_navbar_right_contents[i]["title"]   = @browser.button(:xpath, xpath_div + "/button").attribute_value('title')
        @elems_navbar_right_contents[i]["select"]  = @browser.button(:xpath, xpath_div + "/select")

      when :link

        xpath_link = getNavBarRightXPath + "[#{i+1}]/a"
        @elems_navbar_right_contents[i]["xpath"] = xpath_link
        @elems_navbar_right_contents[i]["link"]  = @browser.link(:xpath, xpath_link)
        @elems_navbar_right_contents[i]["href"]  = @browser.link(:xpath, xpath_link).attribute_value('href')
        @elems_navbar_right_contents[i]["title"] = @browser.link(:xpath, xpath_link).text
        @elems_navbar_right_contents[i]["icon"]  = @browser.link(:xpath, xpath_link).i.attribute_value('class')

      when :form

        xpath_form = getNavBarRightXPath + "[#{i+1}]/form"
        @elems_navbar_right_contents[i]["xpath"] = xpath_form
        @elems_navbar_right_contents[i]["name"]  = @browser.form(:xpath, xpath_form).attribute_value('name')
        @elems_navbar_right_contents[i]["link"]  = @browser.link(:xpath, xpath_form + "/a")
        @elems_navbar_right_contents[i]["href"]  = @browser.link(:xpath, xpath_form + "/a").attribute_value('href')
        @elems_navbar_right_contents[i]["title"] = @browser.link(:xpath, xpath_form + "/a").text
        @elems_navbar_right_contents[i]["icon"]  = @browser.link(:xpath, xpath_form + "/a").i.attribute_value('class')

      else
      end
    # Prints right navbar contents
    #  puts "i = #{i}   type = #{type}   contents: #{@elems_navbar_right_contents[i]}"

    #  puts "--------------------------------------------------------------"
    #  puts "\n"

    # Appends last data element
    #  @elems_navbar_right_contents << @elems_navbar_right_contents[i]

    end

    return @elems_navbar_right_contents

  end



  def getActiveLanguage
    getNavBarRightContents if @elems_navbar_right_contents == [] or @elems_navbar_right_contents.nil?

    return @elems_navbar_right_contents[0]["button"].attribute_value('title')
  end



  def selectLanguageByName(name)
    getNavBarRightContents if @elems_navbar_right_contents == [] or @elems_navbar_right_contents.nil?

    return name if @browser.button(:xpath, @elems_navbar_right_contents[0]["xpath"] + "/button[@title='#{name}']").exists?

    puts "Selecting language >#{name}<"

    @elems_navbar_right_contents[0]["button"].click

    sleep 1

    #@elems_navbar_right_contents[0]["select"].select(name)
    #@browser.select_list(:xpath, @elems_navbar_right_contents[0]["xpath"] + "/select").select("Nederlands")
    #@browser.select_list(:id, 'lang-selection').select("Nederlands")

    @browser.span(:xpath, @elems_navbar_right_contents[0]["xpath"] + "/div/ul/li/a/span[contains(text(), '#{name}')]").click

    sleep 1

    waitLoading

    return @elems_navbar_right_contents[0]["button"].attribute_value('title')
  end

  def to_s
    #"Class CNavBar:\n" +
    "Class >#{self.class.name}<:\n" +
    "XPath to nav bar:    >#{self.xpath}<\n" +
    "HTML tag of nav bar: >#{self.elem_navbar}<\n" +
    "Active Module:       >#{self.getActiveModule}<\n" +
    "Active Language:     >#{self.getActiveLanguage}<\n"
  end

end



# Tested: 20180808
class CFilter

  attr_reader :browser, :xpath, :org_unit, :period, :year, :month, :brand, :touchpoint, :nps_groups
  attr_writer :browser, :xpath, :org_unit, :period, :year, :month, :brand, :touchpoint, :nps_groups



  def initialize(browser, xpath, org_unit = ["Netherlands"], period = "12 month rolling", year = "2018", month = "February", brand = "ALL", touchpoint = "ALL", nps_groups = [ "Detractor", "Neutral", "Promoter" ])
    @browser    = browser
    @xpath      = xpath
    @org_unit   = org_unit
    @period     = period
    @year       = year
    @month      = month
    @brand      = brand
    @touchpoint = touchpoint
    @nps_groups = nps_groups
  end



  def setBrowser(browser)
    self.browser = browser
  end



  def waitLoading
    puts "Loading data ..."

    self.browser.div(:xpath => "//div[@class='temp-container']/div[@class='placeholder-loader' and not (@id='interviewCount')]").wait_while_present
  end



  def getFilterElement
    @elem_filter = @browser.div(:xpath, getFilterXPath)
    return @elem_filter
  end



  def getFilterXPath
    return @elem_filter_xpath = xpath
  end



  def getFilterSections
    @sections_filter = @browser.divs(:xpath, getFilterSectionsXPath)
    return @sections_filter
  end



  def getFilterSectionsXPath
    return getFilterXPath + "/div"
  end



  def getFilterSectionPanelHeading
    @section_panel_heading_filter = @browser.div(:xpath, getFilterSectionPanelHeadingXPath)
    return @section_panel_heading_filter
  end



  def getFilterSectionPanelHeadingXPath
    return getFilterSectionsXPath + "[contains(@class, 'panel-heading') and position()=1]"
  end



  def getFilterSectionPanelHeadingText
    @elem_panel_heading_filter_text = @browser.div(:xpath, getFilterSectionPanelHeadingXPath)
    return @elem_panel_heading_filter_text.text if @elem_panel_heading_filter_text.exists?
    return nil
  end



  def getFilterSectionPanelTools
    @section_panel_tools_filter = @browser.div(:xpath, getFilterSectionPanelToolsXPath)
    return @section_panel_tools_filter
  end



  def getFilterSectionPanelToolsXPath
    return getFilterSectionsXPath + "[contains(@class, 'panel-tools') and position()=2]"
  end



  def getFilterSectionPanelToolsDropdowns
    @section_panel_tools_dropdowns_filter = @browser.divs(:xpath, getFilterSectionPanelToolsDropdownsXPath)
    return @section_panel_tools_dropdowns_filter
  end



  def getFilterSectionPanelToolsDropdownsXPath
    return getFilterSectionPanelToolsXPath + "/div/div[contains(@class, 'dropdown')]"
  end



  def getFilterSectionPanelToolsButtons
    @section_panel_tools_buttons_filter = @browser.buttons(:xpath, getFilterSectionPanelToolsButtonsXPath)
    return @section_panel_tools_buttons_filter
  end



  def getFilterSectionPanelToolsButtonsXPath
    return getFilterSectionPanelToolsDropdownsXPath + "/button"
  end



  def getFilterSectionPanelToolsTitles
    @elem_panel_tools_filter_titles = @browser.spans(:xpath, getFilterSectionPanelToolsButtonsXPath + "/span[1]")
    return @elem_panel_tools_filter_titles
  end



  def getFilterSectionPanelToolsTitlesTexts
    return getFilterSectionPanelToolsTitles.map { |title| title.text}
  end



=begin
  def getFilterSectionPanelToolsButton
    @section_panel_tools_button_filter = @browser.button(:xpath, getFilterSectionPanelToolsButtonXPath)
    return @section_panel_tools_button_filter
  end



  def getFilterSectionPanelToolsButtonXPath
    return getFilterSectionPanelToolsXPath + "//div[contains(@class, 'dropdown')]/button"
  end



  def getFilterSectionPanelToolsTitle
    @elem_panel_tools_filter_title = @browser.span(:xpath, getFilterSectionPanelToolsButtonXPath + "/span")
    return @elem_panel_tools_filter_title.text if @elem_panel_tools_filter_title.exists?
    return nil
  end
=end



  def getFilterSectionPanelBody
    @section_panel_body_filter = @browser.div(:xpath, getFilterSectionPanelBodyXPath)
    return @section_panel_body_filter
  end



  def getFilterSectionPanelBodyXPath
    return getFilterSectionsXPath + "[contains(@class, 'panel-body') and position()=3]"
  end



  def getFilterSectionPanelBodyPeriodPicker
    @section_panel_body_filter_period_picker = @browser.div(:xpath, getFilterSectionPanelBodyPeriodPickerXPath)
    return @section_panel_body_filter_period_picker
  end



  def getFilterSectionPanelBodyPeriodPickerXPath
    return getFilterSectionPanelBodyXPath + "/form[@id='sidebar-filter-form']/div[contains(@class, 'periodpicker')]"
  end



  def getFilterSectionPanelBodyPeriodPickerDropdown
    @section_panel_body_filter_period_picker_dropdown = @browser.div(:xpath, getFilterSectionPanelBodyPeriodPickerDropdownXPath)
    return @section_panel_body_filter_period_picker_dropdown
  end



  def getFilterSectionPanelBodyPeriodPickerDropdownXPath
    return getFilterSectionPanelBodyPeriodPickerXPath + "/div[contains(@class, 'periodpicker_dropdown')]"
  end



  def getFilterSectionPanelBodyPeriodPickerButton
    @section_panel_body_filter_period_picker_button = @browser.button(:xpath, getFilterSectionPanelBodyPeriodPickerButtonXPath)
    return @section_panel_body_filter_period_picker_button
  end



  def getFilterSectionPanelBodyPeriodPickerButtonXPath
    return getFilterSectionPanelBodyPeriodPickerDropdownXPath + "/button[@id='periodpicker_dropdown-toggle']"
  end



  def getFilterSectionPanelBodyPeriodPickerMenu
    @section_panel_body_filter_period_picker_menu = @browser.div(:xpath, getFilterSectionPanelBodyPeriodPickerDropdownXPath)
    return @section_panel_body_filter_period_picker_menu
  end



  def getFilterSectionPanelBodyPeriodPickerMenuXPath
    return getFilterSectionPanelBodyPeriodPickerDropdownXPath + "/div[contains(@class, 'dropdown-menu')]"
  end



  def getFilterSectionPanelBodyPeriodPickerMenuHeader
    @section_panel_body_filter_period_picker_menu_header = @browser.div(:xpath, getFilterSectionPanelBodyPeriodPickerMenuHeaderXPath)
    return @section_panel_body_filter_period_picker_menu_header
  end



  def getFilterSectionPanelBodyPeriodPickerMenuHeaderXPath
    return getFilterSectionPanelBodyPeriodPickerMenuXPath + "/div[contains(@class, 'dropdown-header')]"
  end



  def getFilterSectionPanelBodyPeriodPickerMenuHeaderText
    @section_panel_body_filter_period_picker_menu_header_text = @browser.div(:xpath, getFilterSectionPanelBodyPeriodPickerMenuHeaderXPath)
    return @section_panel_body_filter_period_picker_menu_header_text.text.split if @section_panel_body_filter_period_picker_menu_header_text.exists?
    return nil
  end



  def getFilterSectionPanelBodyPeriodPickerMenuBody
    @section_panel_body_filter_period_picker_menu_body = @browser.div(:xpath, getFilterSectionPanelBodyPeriodPickerMenuBodyXPath)
    return @section_panel_body_filter_period_picker_menu_body
  end



  def getFilterSectionPanelBodyPeriodPickerMenuBodyXPath
    return getFilterSectionPanelBodyPeriodPickerMenuXPath + "/div[contains(@class, 'dropdown-body')]"
  end


















  def setOrgUnit(org_unit)
    waitLoading

    self.browser.button(:xpath, "//form[@id='sidebar-filter-form']/div[2]/div/button").click

    sleep 1

    # //form[@id='sidebar-filter-form']/div[2]/div/div/ul/li/a[contains(text(), '#{org_unit[0]}')]/../ul/li/a[contains(text(), '#{org_unit[1]}')]/../ul/li/a[contains(text(), '#{org_unit[2]}')]
    strXpath = "//form[@id='sidebar-filter-form']/div[2]/div/div/div[2]"

    (0..org_unit.size-2).each do |i|

      strXpath += "/ul//li/a[contains(text(), '#{org_unit[i]}')]"
      #puts "strXpath = >#{strXpath}"
      iElem  = self.browser.i(:xpath, strXpath + "/../i")
      ulElem = self.browser.ul(:xpath, strXpath + "/../ul")

      if not ulElem.exists?
        iElem.click
        sleep 1
      end

      strXpath += "/.."

    end

    #self.browser.link(:xpath, "//form[@id='sidebar-filter-form']/div[2]/div/div/div/ul/li/a[contains(text(), '#{org_unit[org_unit.size-1]}')]").click
    strXpath += "/ul//li/a[contains(text(), '#{org_unit[org_unit.size-1]}')]"

    puts "strXpath = >#{strXpath}"
    self.browser.link(:xpath, strXpath).click
    sleep 1

    waitLoading

    puts "org_unit = " + self.browser.span(:xpath, "//form[@id='sidebar-filter-form']/div[2]/div/button/span[2]").text
    self.org_unit = self.browser.span(:xpath, "//form[@id='sidebar-filter-form']/div[2]/div/button/span[2]").text

    sleep 1
  end



  def setPeriod(period)
    waitLoading

    self.browser.button(:xpath, "//form[@id='sidebar-filter-form']/div[3]/div/button").click

    sleep 1

    self.browser.link(:xpath, "//form[@id='sidebar-filter-form']/div[3]/div/div/div[2]/div/ul/li/a[contains(text(), '#{period}')]").click
    #sleep 1

    self.browser.button(:xpath, "//form[@id='sidebar-filter-form']/div[3]/div/button").click

    waitLoading

    puts "period = " + self.browser.span(:xpath, "//form[@id='sidebar-filter-form']/div[3]/div/button/span[2]").text
    self.period = self.browser.span(:xpath, "//form[@id='sidebar-filter-form']/div[3]/div/button/span[2]").text
  end



  def setYear(year)
    waitLoading

    self.browser.button(:xpath, "//form[@id='sidebar-filter-form']/div[3]/button").click

    sleep 1

    self.browser.span(:xpath, "//form[@id='sidebar-filter-form']/div[4]/div/ul/li/a/span[contains(text(), '#{year}')]").click
    #sleep 1

    self.browser.button(:xpath, "//form[@id='sidebar-filter-form']/div[3]/button").click

    waitLoading

    puts "year = " + self.browser.span(:xpath, "//form[@id='sidebar-filter-form']/div[3]/div/button/span[2]").text
    self.year = self.browser.span(:xpath, "//form[@id='sidebar-filter-form']/div[3]/div/button/span[2]").text
  end



  def setMonth(month)
    waitLoading

    self.browser.button(:xpath, "//form[@id='sidebar-filter-form']/div[5]/div/button").click
    sleep 1

    self.browser.span(:xpath, "//form[@id='sidebar-filter-form']/div[5]/div/div/ul/li/a/span[contains(text(), '#{month}')]").click
    #sleep 1

    waitLoading

    puts "month = " + self.browser.span(:xpath, "//form[@id='sidebar-filter-form']/div[5]/div/button/span[1]").text
    self.month = self.browser.span(:xpath, "//form[@id='sidebar-filter-form']/div[5]/div/button/span[1]").text
  end



  def setBrand(brand)
    waitLoading

    self.browser.button(:xpath, "//form[@id='sidebar-filter-form']/div[4]/div/button").click
    sleep 1

    self.browser.span(:xpath, "//form[@id='sidebar-filter-form']/div[4]/div/div/ul/li/a/span[contains(text(), '#{brand}')]").click
    #sleep 1

    waitLoading

    puts "brand = " + self.browser.span(:xpath, "//form[@id='sidebar-filter-form']/div[4]/div/button/span[1]").text
    self.brand = self.browser.span(:xpath, "//form[@id='sidebar-filter-form']/div[4]/div/button/span[1]").text
  end



  def setTouchpoint(touchpoint)
    waitLoading

    self.browser.button(:xpath, "//form[@id='sidebar-filter-form']/div[5]/div/button").click
    sleep 1

    self.browser.span(:xpath, "//form[@id='sidebar-filter-form']/div[5]/div/div/ul/li/a/span[contains(text(), '#{touchpoint}')]").click
    #sleep 1

    waitLoading

    puts "touchpoint = " + self.browser.span(:xpath, "//form[@id='sidebar-filter-form']/div[5]/div/button/span[1]").text
    self.touchpoint = self.browser.span(:xpath, "//form[@id='sidebar-filter-form']/div[5]/div/button/span[1]").text
  end



  def setNPS_groups(nps_groups)
    puts "nps_groups = >#{nps_groups}<"

    nps_groups_current = self.browser.span(:xpath, "//form[@id='sidebar-filter-form']/div[6]/div/button/span[1]").text.delete(' ').split(",")
    puts "nps_groups_current = >#{nps_groups_current}<"

    nps_groups.each do |elem|
      if not nps_groups_current.include?(elem)
        #puts ">#{elem}< is not included in #{nps_groups_current}<"

        self.browser.button(:xpath, "//form[@id='sidebar-filter-form']/div[6]/div/button").click
        sleep 1

        self.browser.span(:xpath, "//form[@id='sidebar-filter-form']/div[6]/div/div/ul/li/a/span[contains(text(), '#{elem}')]").click
        sleep 1

        self.browser.button(:xpath, "//form[@id='sidebar-filter-form']/div[6]/div/button").click
        sleep 1

        waitLoading
      end
    end

    nps_groups_current.each do |elem|
      if not nps_groups.include?(elem)
        #puts ">#{elem}< is not included in #{nps_groups}<"

        self.browser.button(:xpath, "//form[@id='sidebar-filter-form']/div[6]/div/button").click
        sleep 1

        self.browser.span(:xpath, "//form[@id='sidebar-filter-form']/div[6]/div/div/ul/li/a/span[contains(text(), '#{elem}')]").click
        sleep 1

        self.browser.button(:xpath, "//form[@id='sidebar-filter-form']/div[6]/div/button").click
        sleep 1

        waitLoading
      end
    end

    #puts "nps_groups = " + self.browser.span(:xpath, "//form[@id='sidebar-filter-form']/div[6]/div/button/span[1]").text
    self.nps_groups = self.browser.span(:xpath, "//form[@id='sidebar-filter-form']/div[6]/div/button/span[1]").text.delete(' ').split(",")
    puts "self.nps_groups = >#{self.nps_groups}<"
  end



  def to_s_
    #"Class CFilter:\n" +
    "Class >#{self.class.name}<:\n" +
    "Period:      >#{@period}<\n" +
    "Year:        >#{@year}<\n" +
    "Month:       >#{@month}<\n" +
    "Brand:       >#{@brand}<\n" +
    "Touchpoint:  >#{@touchpoint}<\n" +
    "NPS Groups:  >#{@nps_groups}<\n"
  end



  def to_s
    #"Class CFilter:\n" +
    "Class >#{self.class.name}<:\n" +
    "Org Unit:    >#{self.org_unit}<\n" +
    "Period:      >#{self.period}<\n" +
    "Year:        >#{self.year}<\n" +
    "Month:       >#{self.month}<\n" +
    "Brand:       >#{self.brand}<\n" +
    "Touchpoint:  >#{self.touchpoint}<\n" +
    "NPS Groups:  >#{self.nps_groups}<\n"
  end

end



# Tested: 20180810 OK
class CPeriodPicker

  attr_reader :browser, :xpath, :elem_period_picker, :button, :title, :value, :today
  #attr_writer :browser, :xpath, :elem_period_picker, :button, :title, :value, :today



  def initialize(browser, xpath)
    @browser             = browser
    @xpath               = xpath
    @elem_period_picker  = browser.div(:xpath, @xpath)
    @button              = getButton
    @title               = getTitle
    @value               = getValue
    @today               = getToday
  end



  def setBrowser(browser)
    self.browser = browser
  end



  def getPeriodPickerElement
    @elem_period_picker = @browser.div(:xpath, @xpath)
    return @elem_period_picker
  end



  def getButton
    @button = @browser.button(:xpath, @xpath + "/div/button[@id='periodpicker_dropdown-toggle']")
    return button
  end



  def getTitle
    @title = @button.span.text
    return @title
  end



  def getValue
    @value = @button.spans[1].text
    return @value
  end



  def openPeriodPicker
    getButton.click
    sleep 1
  end



  def closePeriodPicker
    openPeriodPicker
  end



  def getToday
     @today = @browser.link(:xpath, @xpath + "/div/div/div/a[@id='periodpicker-select-today']")
     return @today
  end



  def setPeriod(period)
    openPeriodPicker if getButton.attribute_value('aria-expanded').include? "true"



    sleep 3



    closePeriodPicker
  end



  def to_s
    #"Class CPeriodPicker:\n" +
    "Class >#{self.class.name}<:\n" +
    "XPath to period picker:   >#{self.xpath}<\n" +
    "HTML period picker tag:   >#{self.elem_period_picker}<\n" +
    "Button:                   >#{self.button}<\n" +
    "Title:                    >#{self.title}<\n" +
    "Value:                    >#{self.value}<\n" +
    "Today:                    >#{self.today}<\n"
  end

end



# Tested: 20180808 OK
class CSideBar

  attr_reader :browser, :xpath, :xpath_interview_count, :xpath_filter_area, :xpath_info
  attr_writer :browser, :xpath, :xpath_interview_count, :xpath_filter_area, :xpath_info



  def initialize(browser, xpath)
    @browser = browser
    @xpath   = xpath
  end



  def setBrowser(browser)
    self.browser = browser
  end



  def getSidebarElement
    @elem_sidebar = @browser.div(:xpath, getSidebarXPath)
    return @elem_sidebar
  end



  def getSidebarXPath
    return @elem_sidebar_xpath = xpath
  end



  def getSidebarSections
    @sections_sidebar = @browser.divs(:xpath, getSidebarSectionsXPath)
    return @sections_sidebar
  end



  def getSidebarSectionsXPath
    return getSidebarXPath + "/div"
  end



  def getSidebarSectionInterviewCount
    @section_interview_count_sidebar = @browser.div(:xpath, getSidebarSectionInterviewCountXPath)
    return @section_interview_count_sidebar
  end



  def getSidebarSectionInterviewCountXPath
    return getSidebarSectionsXPath + "[@id='interviewCount' and position()=1]"
  end



  def getSidebarSectionInterviewCountCount
    @elem_interview_count_count = @browser.div(:xpath, getSidebarSectionInterviewCountXPath + "//div[contains(@class, 'panel-heading')]/div")
    return @elem_interview_count_count.text if @elem_interview_count_count.exists?
    return nil
  end



  def getSidebarSectionInterviewCountText
    @elem_interview_count_text = @browser.span(:xpath, getSidebarSectionInterviewCountXPath + "//div[contains(@class, 'panel-heading')]/span")
    return @elem_interview_count_text.text if @elem_interview_count_text.exists?
    return nil
  end



  def getSidebarSectionFilter
    @section_filter_sidebar = @browser.div(:xpath, getSidebarSectionFilterXPath)
    return @section_filter_sidebar
  end



  def getSidebarSectionFilterXPath
    return getSidebarSectionsXPath + "[@id='panel-org-tree' and position()=2]"
  end



  def getSidebarSectionInfoText
    @section_info_text_sidebar = @browser.div(:xpath, getSidebarSectionInfoTextXPath)
    return @section_info_text_sidebar
  end



  def getSidebarSectionInfoTextXPath
    return getSidebarSectionsXPath + "[@id='info-text' and position()=3]"
  end



  def getSidebarSectionInfoTextTitle
    @elem_info_text_title = @browser.div(:xpath, getSidebarSectionInfoTextXPath + "/div[contains(@class, 'panel-heading')]")
    return @elem_info_text_title.text if @elem_info_text_title.exists?
    return nil
  end



  def getSidebarSectionInfoTextText
    @elem_info_text_text = @browser.div(:xpath, getSidebarSectionInfoTextXPath + "/div[contains(@class, 'panel-body')]")
    return @elem_info_text_text.text if @elem_info_text_text.exists?
    return nil
  end



  def getSidebarSectionExcelExports
    @section_excel_exports_sidebar = @browser.div(:xpath, getSidebarSectionExcelExportsXPath)
    return @section_excel_exports_sidebar
  end



  def getSidebarSectionExcelExportsXPath
    return getSidebarSectionsXPath + "[contains(@class, 'panel') and position()=4]"
  end



  def getSidebarSectionExcelExportsTitle
    @elem_excel_exports_title = @browser.div(:xpath, getSidebarSectionExcelExportsXPath + "/div[contains(@class, 'panel-heading')]")
    return @elem_excel_exports_title.text if @elem_excel_exports_title.exists?
    return nil
  end



  def getSidebarSectionExcelExportsList
    @elem_excel_exports_list = @browser.links(:xpath, getSidebarSectionExcelExportsXPath + "/div[contains(@class, 'list-group')]/a")

    aExcelExports = []

    @elem_excel_exports_list.each do |elem|

      hExcelExport = {}

      hExcelExport["filename"] = elem.spans[0].text
      hExcelExport["size"] = elem.spans[1].text
      hExcelExport["datetime"] = elem.div.text

      aExcelExports << hExcelExport

    end

    return aExcelExports
  end



  def to_s
    #"Class CSidebar:\n" +
    "Class >#{self.class.name}<:\n" +
    "XPath to sidebar:         >#{self.xpath}<\n" +
    "XPath to interview count: >#{self.xpath_interview_count}<\n" +
    "XPath to filter area:     >#{self.xpath_filter_area}<\n" +
    "XPath to info text:       >#{self.xpath_info}<\n"
  end

end



# Tested: 20180808 OK
class CTable

  attr_reader :browser, :org_unit, :xpath, :elem_table, :num_cols
  #attr_writer :browser, :org_unit, :xpath, :elem_table, :num_cols



  def waitLoading
    puts "Loading data ..."

    self.browser.div(:xpath => "//div[@class='temp-container']/div[@class='placeholder-loader' and not (@id='interviewCount')]").wait_while_present
  end



=begin
  def initialize(browser, xpath)
    @browser    = browser

    waitLoading

    @xpath      = xpath
    @elem_table = @browser.table(:xpath, @xpath)
    @num_cols   = getNumCols
  end
=end



  def initialize(browser, xpath = nil, elem_table = nil)
    @browser    = browser

    waitLoading

    @xpath      = xpath

    if xpath.nil?
      @elem_table = elem_table
    else
      @elem_table = @browser.table(:xpath, @xpath)
    end

    @num_cols   = getNumCols
  end



  def setBrowser(browser)
    self.browser = browser
  end



  def getNumCols
    if self.elem_table.exists?
      if self.elem_table.thead.exists?
        if self.elem_table.thead.tr.exists?
          puts "#{self.class.name} - self.elem_table.thead.tr.ths.size: #{self.elem_table.thead.tr.ths.size}"
          return self.elem_table.thead.tr.ths.size
        else
          puts "#{self.class.name}: table/thead/tr does NOT exist"
          return nil
        end

      else
        puts "#{self.class.name}: table/thead does NOT exist"

        if self.elem_table.tbody.exists?
          if self.elem_table.tbody.tr.exists?
            if self.elem_table.tbody.tr.td.exists?
              puts "#{self.class.name} - self.elem_table.tbody.tr.tds.size: #{self.elem_table.tbody.tr.tds.size}"
              return self.elem_table.tbody.tr.tds.size
            else
              puts "#{self.class.name}: table/tbody/tr/td does NOT exist"
              return nil
            end
          else
            puts "#{self.class.name}: table/tbody/tr does NOT exist"
            return nil
          end
        else
          puts "#{self.class.name}: table/tbody does NOT exist"
          return nil
        end

      end
    else
      puts "#{self.class.name}: table does NOT exist"
      return nil
    end

  end



  def getNumRowsVisible
    if self.elem_table.exists?

      if self.elem_table.tbody.exists?
        if self.elem_table.tbody.tr.exists?
          puts "#{self.class.name} - self.elem_table.tbody.trs.size: #{self.elem_table.tbody.trs.size}"
          return self.elem_table.tbody.trs.size
        else
          puts "#{self.class.name}: table/tbody/tr does NOT exist"
          return nil
        end
      else
        puts "#{self.class.name}: table/tbody does NOT exist"
        return nil
      end

    else
      puts "#{self.class.name}: table does NOT exist"
      return nil
    end

  end



=begin
  def getRowsVisible
    if self.elem_table.exists?

      if self.elem_table.tbody.exists?
        if self.elem_table.tbody.tr.exists?
          #puts "#{self.class.name} - self.elem_table.tbody.trs.size: #{self.elem_table.tbody.trs.size}"

          aResultSet = []

          #(0..self.elem_table.tbody.trs.size-1).each do |i_tr|
          (9..9).each do |i_tr|
            puts "i_tr = #{i_tr}"

            aResultSet[i_tr] = []

            elem_tr = self.elem_table.tbody.trs[i_tr]

            #(0..elem_tr.tds.size-1).each do |i_td|
            (0..1).each do |i_td|
              puts "i_td = #{i_td}"

              aResultSet[i_tr][i_td] = {}

              elem_td = elem_tr.tds[i_td]

              time_start_class = Time.now

              if elem_td.i.exists?
                #puts "#{self.class.name} - self.elem_table.tbody.trs[#{i_tr}].tds[#{i_td}].i[@class]: >#{elem_td.i.attribute_value('class')}<"
                aResultSet[i_tr][i_td]["class"] = elem_td.i.attribute_value('class')

                if elem_td.span.exists?
                  #puts "#{self.class.name} - self.elem_table.tbody.trs[#{i_tr}].tds[#{i_td}].span.text: >#{elem_td.span.text}<"
                  aResultSet[i_tr][i_td]["span"] = elem_td.span.text
                end
              else
                #puts "#{self.class.name} - self.elem_table.tbody.trs[#{i_tr}].tds[#{i_td}].text: >#{elem_td.text}<"
                aResultSet[i_tr][i_td]["text"] = elem_td.text
              end

              time_end_class = Time.now

              puts "class - duration = #{time_end_class - time_start_class}"
            end

          end

          return aResultSet
        else
          puts "#{self.class.name}: table/tbody/tr does NOT exist"
          return nil
        end
      else
        puts "#{self.class.name}: table/tbody does NOT exist"
        return nil
      end

    else
      puts "#{self.class.name}: table does NOT exist"
      return nil
    end

  end
=end



  def getRowsVisible(iStartRow = 0, iNumRows = 0, iStartCol = 0, iNumCols = 0)

    puts "#{self.class.name} - reading table data ..."

    if self.elem_table.exists?

      if self.elem_table.tbody.exists?

        if self.elem_table.tbody.tr.exists?
          #html_table_body = Nokogiri::HTML(@elem_table.tbody.inner_html)
          #puts html_table_body.xpath('//tr')

          #puts "#{self.class.name} - self.elem_table.tbody.trs.size: #{self.elem_table.tbody.trs.size}"

          aResultSet = []

          iEndRow = ( iNumRows == 0 ? self.elem_table.tbody.trs.size - 1 : [iStartRow + iNumRows, self.elem_table.tbody.trs.size].min - 1 )

          ([iStartRow, 0].max..iEndRow).each do |i_tr|
            #puts "i_tr = #{i_tr}"

            aResultSet[i_tr] = []

            elem_tr = self.elem_table.tbody.trs[i_tr]

            iEndCol = ( iNumCols == 0 ? elem_tr.tds.size - 1 : [iStartCol + iNumCols, @num_cols].min - 1 )

            ([iStartCol, 0].max..iEndCol).each do |i_td|
              #puts "i_td = #{i_td}"

              aResultSet[i_tr][i_td] = {}

              elem_td = elem_tr.tds[i_td]

              html_td = Nokogiri::HTML(elem_td.inner_html)
              #puts html_td

              #if elem_td.i.exists?
              if html_td.to_s.include? "<i"
                #html_i = Nokogiri::HTML(elem_td.i.inner_html)
                #puts ">#{html_i}"

                #puts "#{self.class.name} - self.elem_table.tbody.trs[#{i_tr}].tds[#{i_td}].i[@class]: >#{elem_td.i.attribute_value('class')}<"
                aResultSet[i_tr][i_td]["class"] = elem_td.i.attribute_value('class')

                #if elem_td.span.exists?
                if html_td.to_s.include? "<span"
                  #puts "#{self.class.name} - self.elem_table.tbody.trs[#{i_tr}].tds[#{i_td}].span.text: >#{elem_td.span.text}<"
                  aResultSet[i_tr][i_td]["span"] = elem_td.span.text
                end
              else
                #puts "#{self.class.name} - self.elem_table.tbody.trs[#{i_tr}].tds[#{i_td}].text: >#{elem_td.text}<"
                aResultSet[i_tr][i_td]["text"] = elem_td.text
              end

            end

          end

          return aResultSet
        else
          puts "#{self.class.name}: table/tbody/tr does NOT exist"
          return nil
        end
      else
        puts "#{self.class.name}: table/tbody does NOT exist"
        return nil
      end

    else
      puts "#{self.class.name}: table does NOT exist"
      return nil
    end

  end



  def getRow(index)
    getRowsVisible[index]
  end



  def getColHeader
    if self.elem_table.exists?
      if self.elem_table.thead.exists?
        if self.elem_table.thead.tr.exists?
          aColHeader = []

          (0..self.elem_table.thead.tr.ths.size-1).each do |i|
            puts "i = #{i}"

            aColHeader[i] = {}

            elem_th = self.elem_table.thead.tr.ths[i]

            if elem_th.exists?

              elem_span = elem_th.span

              if elem_span.exists?
                aColHeader[i]["text"] = elem_span.text
                #puts ">#{aColHeader[i]["text"]}<"
                aColHeader[i]["dot"] = elem_span.attribute_value('data-original-title')
                #puts ">#{aColHeader[i]["dot"]}<"

                if elem_span.i.exists?
                  aColHeader[i]["class"] = elem_span.i.attribute_value('class')
                  #puts ">#{aColHeader[i]["class"]}<"
                end
              else
                aColHeader[i]["text"] = elem_th.text
                #puts ">#{aColHeader[i]["text"]}<"

                if elem_th.i.exists?
                  aColHeader[i]["class"] = elem_th.i.attribute_value('class')
                  #puts ">#{aColHeader[i]["class"]}<"
                end
              end

            end

          end

          return aColHeader

        else
          puts "#{self.class.name}: table/thead/tr does NOT exist"
          return nil
        end

      else
        puts "#{self.class.name}: table/thead does NOT exist"
        return nil
      end
    else
      puts "#{self.class.name}: table does NOT exist"
      return nil
    end

  end



  def getRowsNode

    return nil if getNumRowsVisible.nil?

    return self.elem_table.tbody.trs

  end



  def to_s
    #"Class CTable:\n" +
    "Class >#{self.class.name}<:\n" +
    "XPath to table: >#{self.xpath}<\n" +
    "HTML table tag: >#{self.elem_table}<\n" +
    "Number of cols: >#{self.num_cols}<\n"
  end

end



# Tested: 20180808 OK
class CPagination

  attr_reader :browser, :xpath, :elem_pagination, :page_selected, :table
  #attr_writer :browser, :xpath, :elem_pagination, :page_selected, :table



  def initialize(browser, xpath, table = nil)
    @browser         = browser
    @xpath           = xpath
    @elem_pagination = browser.nav(:xpath, @xpath)
    @page_selected   = getPageSelected
    @table           = table
  end



  def setBrowser(browser)
    self.browser = browser
  end



  def waitLoadingTableData
    puts "Loading table data ..."

    if @table.nil?
      @browser.div(:xpath, @xpath + "/../div[contains(@class, 'loader')]").wait_while_present
    else
      @browser.div(:xpath, @xpath + "/../div[contains(@class, 'loader')]").wait_while_present
    end
  end



  def getPageSelected
    @page_selected = @browser.span(:xpath, @xpath + "/ul/li[@class='active']/span").text.to_i
    return @page_selected
  end



  def selectPrevPage
    return if @elem_pagination.ul.lis[0].attribute_value("class") == "disabled"

    @elem_pagination.ul.lis[0].a.click

    waitLoadingTableData

    getPageSelected
  end



  def selectNextPage
    return if @browser.li(:xpath, @xpath + "/ul/li[@class='disabled' and position()=last()]").exists?

    @browser.link(:xpath, @xpath + "/ul/li[position()=last()]/a").click

    waitLoadingTableData

    getPageSelected
  end



  def selectPage(iNumPage)
    return iNumPage if @browser.span(:xpath, @xpath + "/ul/li[@class='active']/span").text.to_i == iNumPage

    @elem_page = @browser.link(:xpath, @xpath + "/ul/li/a[contains(text(), '#{iNumPage}') and string-length(text()) = #{iNumPage.to_s.length}]")

    #return iNumPage if not @elem_page.exists?

    if not @elem_page.exists?
      puts "#{self.class.name}: page #{iNumPage} is NOT visible"
      return iNumPage
    end

    @elem_page.click

    waitLoadingTableData

    getPageSelected
  end



  def to_s
    #"Class CPagination:\n" +
    "Class >#{self.class.name}<:\n" +
    "XPath to pagination: >#{self.xpath}<\n" +
    "HTML pagination tag: >#{self.elem_pagination}<\n" +
    "Page selected:       >#{self.page_selected}<\n" +
    "Table referenced:    >#{self.table.class.name}<\n"
  end

end



# Tested: 20180808 OK
class CResultsPerPage

  attr_reader :browser, :xpath, :elem_num_results, :num_selected, :table
  #attr_writer :browser, :xpath, :elem_num_results, :num_selected, :table



  def initialize(browser, xpath, table = nil)
    @browser          = browser
    @xpath            = xpath
    @elem_num_results = browser.div(:xpath, @xpath)
    @num_selected     = getNumSelected
    @table            = table
  end



  def setBrowser(browser)
    self.browser = browser
  end



  def waitLoading
    puts "Loading data ..."

    self.browser.div(:xpath => @table.xpath + "/../div[@class='targeted-loader']").wait_while_present
  end



  def getNumSelected
    @num_selected = @elem_num_results.button.attribute_value("title").split[-1].to_i
    return @num_selected
  end



  def setNumRows(iNumRows)
    return iNumRows if @elem_num_results.button.attribute_value("title").split[-1].to_i == iNumRows

    waitLoading

    @browser.button(:xpath, @xpath + "/" + "button").click

    @browser.span(:xpath, @xpath + "/" + "div/ul/li/a/span[contains(text(), '#{iNumRows}')]").click

    puts "Loading table data ..."

    if @table.nil?
      while @elem_num_results.button.attribute_value("class").include? "disabled"
      end
    else
      @browser.div(:xpath, @table.xpath + "/../div[contains(@class, 'loader')]").wait_while_present
    end

    @num_selected = @elem_num_results.button.attribute_value("title").split[-1].to_i
    return @num_selected
  end



  def to_s
    #"Class CResultsPerPage:\n" +
    "Class >#{self.class.name}<:\n" +
    "XPath to element: >#{self.xpath}<\n" +
    "HTML element tag: >#{self.elem_num_results}<\n" +
    "Number selected:  >#{self.num_selected}<\n" +
    "Table referenced: >#{self.table.class.name}<\n"
  end

end



# Tested: 20180808 OK
class CInterviewFilters

  attr_reader :browser, :xpath, :elem_filters, :num_filters, :filter_status, :table
  #attr_writer :browser, :xpath, :elem_filters, :num_filters, :filter_status, :table



  def initialize(browser, xpath, table = nil)
    @browser       = browser
    @xpath         = xpath
    @elem_filters  = browser.form(:xpath, @xpath)
    @num_filters   = getNumFilters
    @filter_status = getFilterStatus
    @table         = table
  end



  def setBrowser(browser)
    self.browser = browser
  end



  def waitLoading
    puts "Loading table data ..."

    self.browser.div(:xpath => @table.xpath + "/../div[@class='targeted-loader']").wait_while_present
  end



  def getNumFilters
    @num_filters = @elem_filters.divs.size
    return @num_filters
  end



  def getFilterTitles
    @filter_titles = []

    (0..@elem_filters.divs.size - 1).each do |i|
      @filter_titles << @elem_filters.divs[i].label.text
    end

    return @filter_titles
  end



  def getFilterStatus(iFilter = @num_filters)
    @filter_status = [] if not @filter_status

    if iFilter.abs >= @num_filters
      iFrom = 0
      iTo = @num_filters - 1
    else
      iFrom = iTo = iFilter.abs
    end

    (iFrom..iTo).each do |i|
      @filter_status[i] = @elem_filters.divs[i].input.checked?
    end

    if iFilter.abs >= @num_filters
      return @filter_status
    else
      return @filter_status[iFilter.abs]
    end
  end



  def clickFilterCheckBox(bCheck, iFilter = @num_filters)
    if iFilter.abs >= @num_filters
      iFrom = 0
      iTo = @num_filters - 1
    else
      iFrom = iTo = iFilter.abs
    end

    (iFrom..iTo).each do |i|

      bCheckBox = !@elem_filters.divs[i].input.checked? if bCheck
      bCheckBox = @elem_filters.divs[i].input.checked? if not bCheck

      if bCheckBox
        @elem_filters.divs[i].input.click

        waitLoading

        @filter_status[i] = @elem_filters.divs[i].input.checked?
      end

    end

    if iFilter.abs >= @num_filters
      return @filter_status
    else
      return @filter_status[iFilter.abs]
    end
  end



  def enableFilter(iFilter = @num_filters)
    clickFilterCheckBox(true, iFilter)
  end



  def disableFilter(iFilter = @num_filters)
    clickFilterCheckBox(false, iFilter)
  end



  def to_s
    #"Class CInterviewFilters:\n" +
    "Class >#{self.class.name}<:\n" +
    "XPath to element:  >#{self.xpath}<\n" +
    "HTML element tag:  >#{self.elem_filters}<\n" +
    "Number of filters: >#{self.num_filters}<\n" +
    "Status of filters: >#{self.filter_status}<\n" +
    "Table referenced:  >#{self.table.class.name}<\n"
  end

end



# Tested: 20180808 OK
class CPanel

  attr_reader :browser, :xpath, :elem_panel, :count, :title, :table
  #attr_writer :browser, :xpath, :elem_panel, :count, :title, :table



  def initialize(browser, xpath, table = nil)
    @browser    = browser
    @xpath      = xpath
    @elem_panel = browser.div(:xpath, @xpath)
    @count      = getCount
    @title      = getTitle
    @table      = table
  end



  def setBrowser(browser)
    self.browser = browser
  end



  def getCount
    @count = @elem_panel.div.text.to_i
    return @count
  end



  def getTitle
    @title = @elem_panel.span.text
    return @title
  end



  def to_s
    #"Class CPanel:\n" +
    "Class >#{self.class.name}<:\n" +
    "XPath to panel:   >#{self.xpath}<\n" +
    "HTML panel tag:   >#{self.elem_panel}<\n" +
    "Count:            >#{self.count}<\n" +
    "Title:            >#{self.title}<\n" +
    "Table referenced: >#{self.table.class.name}<\n"
  end

end



# Tested: 20180808 OK
class CInterviewDetail

  attr_reader :browser, :xpath, :elem_detail, :elem_header, :elem_body, :elem_navigation, :elem_footer, :table
  #attr_writer :browser, :xpath, :elem_detail, :elem_header, :elem_body, :elem_navigation, :elem_footer, :table



  def initialize(browser, xpath, table = nil)
    @browser     = browser
    @xpath       = xpath
    @elem_detail = browser.div(:xpath, @xpath)
    @elem_header = getHeaderElement
    @elem_body   = getBodyElement
    @elem_footer = getFooterElement
    @table       = table
  end



  def setBrowser(browser)
    #self.browser = browser
    @browser = browser
  end



  def getHeaderElement
    @elem_header = @browser.div(:xpath, getHeaderXPath)
    return @elem_header
  end



  def getHeaderXPath
    return @elem_header_xpath = xpath + "//div[@class='modal-header']"
  end



  def getBodyElement
    @elem_body = @browser.div(:xpath, getBodyXPath)
    return @elem_body
  end



  def getBodyXPath
    return @elem_body_xpath = xpath + "//div[@class='modal-body']"
  end



  def getBodySectionXPath(i)
    return getBodyXpath + "//h1/following-sibling::div/div[#{i}]"
  end



  def getFooterElement
    @elem_footer = @browser.div(:xpath, getFooterXPath)
    return @elem_footer
  end



  def getFooterXPath
    return @elem_footer_xpath = xpath + "//div[@class='modal-footer']"
  end



  def getHeaderTitle
    return @elem_header.h4.text if @elem_header.h4.exists?
    return nil
  end



  def getHeaderClose
    return @elem_header.button if @elem_header.button.exists?
    return nil
  end



  def getBodyTitle
    return @elem_body.h1.text if @elem_body.h1.exists?
    return nil
  end



  def getBodyTitleXPath
    return getBodyXPath + "//h1"
  end



  def getNavigationElement
    @elem_navigation = @browser.div(:xpath, getNavigationElementXPath)
    return @elem_navigation
  end



  def getNavigationElementXPath
    return @elem_navigation_xpath = getBodyXPath + "//div[@id='detailNavigation']"
  end



  def getNavigationButtons
    return @elem_navigation.buttons if @elem_navigation.button.exists?
    return nil
  end



  def getNavigationButtonsXPath
    return getNavigationElementXPath + "//button"
  end



  def previousDetailView
    return if getNavigationButtons[0].attribute_value('disabled') == "disabled"
    getNavigationButtons[0].click
    sleep 2
  end



  def nextDetailView
    return if getNavigationButtons[1].attribute_value('disabled') == "disabled"
    getNavigationButtons[1].click
    sleep 2
  end



  def getAlertElement
    @elem_alert = @browser.div(:xpath, getAlertElementXPath)
    return @elem_alert
  end



  def getAlertElementXPath
    return @elem_alert_xpath = getBodyXPath + "//div[@class='row']//div[contains(@class, 'alert') and @role='alert']"
  end



  def getAlertLines
    return @elem_alert.spans if @elem_alert.span.exists?
    return nil
  end



  def getAlertLinesXPath
    return getAlertElementXPath + "//span"
  end



  def getAlertLinesText
    getAlertLines.collect { |alert| alert.text }
  end



  def getAlertLinesSymbol
    getAlertLines.collect { |alert| alert.i.attribute_value('class') }
  end



  def getDetailDataTables
    @tables_detail_data = @browser.tables(:xpath, getDetailDataTablesXPath)
    return @tables_detail_data
  end



  def getDetailDataTablesXPath
    return @tables_detail_data_xpath = getBodyXPath + "//div[@class='row']/div/table"
  end



  def getDetailDataTabs
    @tabs_detail_data = @browser.lis(:xpath, getDetailDataTabsXPath)
    return @tabs_detail_data
  end



  def getDetailDataTabsXPath
    return @tabs_detail_data_xpath = getBodyXPath + "//div[@class='row']/div/ul/li"
  end



  def getDetailDataTabsAttrs
    getDetailDataTabs.collect { |tab| { "class" => "#{tab.attribute_value('class')}", "role" => "#{tab.attribute_value('role')}" } }
  end



  def getDetailDataTabsLinks
    getDetailDataTabs.collect { |tab| tab.link }
  end



  def getDetailDataTabsCaptions
    getDetailDataTabs.collect { |tab| tab.link.text }
  end



  def getDetailDataTabsCaptions_
    getDetailDataTabsLinks.collect { |link| link.text }
  end



  def getDetailDataTabsContents
    @tabs_contents_detail_data = @browser.divs(:xpath, getDetailDataTabsContentsXPath)
    return @tabs_contents_detail_data
  end



  def getDetailDataTabsContentsXPath
    return @tabs_contents_detail_data_xpath = getBodyXPath + "//div[@class='row']/div/div/div[@class='tab-content']/div"
  end



  def getDetailDataTabsContentsTables
    @tables_detail_data_tabs_contents = @browser.tables(:xpath, getDetailDataTabsContentsTablesXPath)
    return @tables_detail_data_tabs_contents
  end



  def getDetailDataTabsContentsTablesXPath
    return @tables_detail_data_tabs_contents_xpath = getDetailDataTabsContentsXPath + "//table"
  end























  def getFooterButtons
    return @elem_footer.buttons if @elem_footer.button.exists?
    return nil
  end



  def getFooterButtonsXPath
    return getFooterXPath + "//button"
  end



  def getFooterButtonsText
    getFooterButtons.collect { |button| button.text }
  end



  def getFooterLinks
    return @elem_footer.links if @elem_footer.link.exists?
    return nil
  end



  def getFooterLinksXPath
    return getFooterXPath + "//a"
  end



  def getFooterLinksText
    getFooterLinks.collect { |link| link.text }
  end



  def to_s
    #"Class CInterviewDetail:\n" +
    "Class >#{self.class.name}<:\n" +
    "XPath to panel:   >#{self.xpath}<\n" +
    "HTML detail tag:  >#{self.elem_detail}<\n" +
    "HTML header tag:  >#{self.elem_header}<\n" +
    "HTML body tag:    >#{self.elem_body}<\n" +
    "HTML footer tag:  >#{self.elem_footer}<\n" +
    "Table referenced: >#{self.table.class.name}<\n"
  end

end



# Tested: 20180810 OK
class CInformation

  attr_reader :browser, :xpath, :elem_info, :title, :text
  #attr_writer :browser, :xpath, :elem_info, :title, :text



  def initialize(browser, xpath)
    @browser    = browser
    @xpath      = xpath
    @elem_info  = browser.div(:xpath, @xpath)
    @title      = getTitle
    @text       = getText
  end



  def setBrowser(browser)
    self.browser = browser
  end



  def getTitle
    @title = @elem_info.div.text
    return @title
  end



  def getText
    @text = @elem_info.divs[1].text
    return @text
  end



  def to_s
    #"Class CInformation:\n" +
    "Class >#{self.class.name}<:\n" +
    "XPath to panel:   >#{self.xpath}<\n" +
    "HTML panel tag:   >#{self.elem_info}<\n" +
    "Title:            >#{self.title}<\n" +
    "Text:             >#{self.text}<\n"
  end

end



# Tested: 20180810 OK
class CExcelExports

  attr_reader :browser, :xpath, :elem_excel_exports, :title, :list
  #attr_writer :browser, :xpath, :elem_excel_exports, :title, :list



  def initialize(browser, xpath)
    @browser             = browser
    @xpath               = xpath
    @elem_excel_exports  = browser.div(:xpath, @xpath)
    @title               = getTitle
    @list                = getList
  end



  def setBrowser(browser)
    self.browser = browser
  end



  def getTitle
    @title = @elem_excel_exports.div.text
    return @title
  end



  def getList
    aExcelExports = []

    @elem_excel_exports.divs[1].links.each do |link|

      hExcelExport = {}

      hExcelExport["filename"]   = link.attribute_value("data-original-title")
      hExcelExport["short_text"] = link.span.span.text
      hExcelExport["info"]       = link.div.text

      aTemp = link.div.text.split('|')

      hExcelExport["size"]       = aTemp[0].strip!
      hExcelExport["date_time"]  = aTemp[1].strip!

      aExcelExports << hExcelExport

    end

    return aExcelExports
  end



  def to_s
    #"Class CExcelExports:\n" +
    "Class >#{self.class.name}<:\n" +
    "XPath to panel:   >#{self.xpath}<\n" +
    "HTML panel tag:   >#{self.elem_excel_exports}<\n" +
    "Title:            >#{self.title}<\n" +
    "List:             >#{self.list}<\n"
  end

end
