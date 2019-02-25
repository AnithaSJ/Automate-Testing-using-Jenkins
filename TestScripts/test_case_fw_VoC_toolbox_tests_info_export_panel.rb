#Encoding: UTF-8
puts "Test: ÄÖÜäöüß\n"

puts "#{Time.new.strftime('%Y.%m.%d %H:%M:%S')} - START TESTING . . .\n"

require "./test_base_fw_VoC"

require "./test_case_fw_VoC_toolbox_module"





class TestExample

# Tested: 20180808 OK
#=begin
  def test_voc_reporting_dashboard
    browse_to_new_project

    login_to_portal("username","Password")

    refresh_home_page



    @message = "'VoC - link VoC Reporting Dashboard' exists?"
    load_link_assert(@timeout_error_length, "link", "xpath", "//a[contains(@href, '/standardReporting/index')]")

    @message = "'VoC - link VoC Reporting Dashboard text=VoC Reporting Dashboard' exists?"
    load_link_assert(@timeout_error_length, "link", "xpath", "//a[contains(@href, '/standardReporting/index') and contains(text(),'VoC Reporting Dashboard')]")


    browser    = @@b
    org_unit   = "Korea"
    period     = "Month"
    year       = "2017"
    month      = "June"
    brand      = "BMW"
    touchpoint = "New Car Sales"
    nps_groups = [ "Detractor", "Neutral", "Promoter" ]

    @filter = CFilter.new(browser, org_unit, period, year, month, brand, touchpoint)

    puts @filter



    #sleep 3



    @filter.setOrgUnit(["Korea (B3-KR)"])
    #@filter.setOrgUnit(["Korea"])
## TODO: failures
    @filter.setPeriod("Yar to date")

    @filter.setBrand("BMV")

    @filter.setTouchpoint("New Car Sales")

    @filter.setNPS_groups([ "Detractor", "Neutral", "Promoter" ])

    puts @filter



    #sleep 3



    browser = @@b
    xpath   = "//div[@id='info-text']"

    @info = CInformation.new(browser, xpath)

    puts @info



    browser = @@b
    xpath   = "//div[contains(@class, 'panel-download')]"

    @excel_exports = CExcelExports.new(browser, xpath)

    puts @excel_exports



    browser = @@b
    xpath   = "//form[@id='sidebar-filter-form']/div[contains(@class, 'periodpicker')]"

    @period_picker = CPeriodPicker.new(browser, xpath)

    puts @period_picker



    @period_picker.openPeriodPicker

    sleep 3

    @period_picker.closePeriodPicker



    @period_picker.setPeriod("Year to date")



    logout_from_portal

  end
#=end

end
