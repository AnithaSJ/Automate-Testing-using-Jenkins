#Encoding: UTF-8
puts "Test: ÄÖÜäöüß\n" 

puts "#{Time.new.strftime('%Y.%m.%d %H:%M:%S')} - START TESTING . . .\n"

require "./test_base_fw_VoC"

require "./test_case_fw_VoC_toolbox_module"



=begin
browser    = nil
period     = "Month"
year       = "2017" 
month      = "June"
brand      = "BMW" 
touchpoint = "New Car Sales"
nps_groups = [ "Detractor", "Neutral", "Promoter" ]
    
#filter = CFilter.new(browser, period, year, month, brand, touchpoint, nps_groups)

filter = CFilter.new(browser, period, year, month, brand, touchpoint)

puts filter



filter.setPeriod("Year to date")
filter.setYear("2016")
filter.setMonth("October")
filter.setBrand("MINI")
filter.setTouchpoint("Service")
filter.setNPS_groups([ "Detractor", "Promoter" ])

puts filter
=end





class TestExample

# Tested: 20180808 OK
#=begin
  def test_voc_reporting_dashboard
    browse_to_new_project

    login_to_portal("ttr_support", "#F3nst3r")

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



    ##@filter.setOrgUnit("Korea (B3-KR)")
    ##@filter.setOrgUnit("Korea")
    ##@filter.setOrgUnit("Turkey")
    ##@filter.setOrgUnit("Italia")
    ##@filter.setOrgUnit("Netherlands")
    
    @filter.setOrgUnit(["Korea (B3-KR)"])
    #@filter.setOrgUnit(["Korea"])
    
    #@filter.setOrgUnit(["Turkey"])
    #@filter.setOrgUnit(["Turkey", "Borusan Oto (Group)"])
    #@filter.setOrgUnit(["Turkey", "Borusan Oto (Group)", "Borusan Oto Birlik"])
    #@filter.setOrgUnit(["Turkey", "Borusan Oto (Group)"])
    #@filter.setOrgUnit(["Turkey"])
    #@filter.setOrgUnit(["Turkey", "Borusan Oto (Group)", "Borusan Oto Çankaya"])
    ##@filter.setOrgUnit(["Turkey", "Badıllı Oto"])
    #@filter.setOrgUnit(["Turkey", "Badilli Oto"])
    #@filter.setOrgUnit(["Turkey", "Ildirar Otomotiv"])
    ##@filter.setOrgUnit(["Turkey", "İnciroğlu"])
    #@filter.setOrgUnit(["Turkey", "Inciroglu"])
    ##@filter.setOrgUnit(["Turkey", "Oto Çamlıbel"])
    #@filter.setOrgUnit(["Turkey", "Oto Çamlibel"])
    #@filter.setOrgUnit(["Turkey", "Üçler Otomotiv"])
    #@filter.setOrgUnit(["Turkey", "Teknik Oto (Group)", "Teknik Oto Eskişehir"])
    #@filter.setOrgUnit(["Turkey", "Teknik Oto (Group)", "Teknik Oto Eskisehir"])
    #@filter.setOrgUnit(["Turkey", "Koçtürk Otomotiv"])
    
    #@filter.setOrgUnit(["Switzerland (B1-CH)", "BMW", "Region 1", "Claude Urfer SA Group - BMW", "Claude Urfer SA Martigny - BMW (20321)"])
    
    #@filter.setOrgUnit(["Italia (B1-IT)", "BMW Italia", "Area 1", "AUTOCROCETTA SPA", "AUTOCROCETTA SPA - 102572"])
    
    ##@filter.setOrgUnit(["Russia (B3-RU)", "Москва"])
    ##@filter.setOrgUnit(["Russia (B3-RU)", "Регионы"])
    ##@filter.setOrgUnit(["Russia (B3-RU)", "Санкт-Петербург"])
    ##@filter.setOrgUnit(["Russia (B3-RU)", "Спутник"])

    ##@filter.setOrgUnit(["B4-R1-Rest", "Egypt (B4-R1-EG", "Alexandria", "Bavarian Auto Service - Alexandria (AFS)"])

    #@filter.setOrgUnit(["Italia"])
    #@filter.setOrgUnit(["Netherlands"])
    
    #@filter.setOrgUnit(["Korea (B3-KR)"])
    @filter.setOrgUnit(["Korea"])

    #@filter.setPeriod("Year to date")
    #@filter.setPeriod("Month")
    #@filter.setPeriod("12 months rolling")
    #@filter.setPeriod("6 months rolling")
    #@filter.setPeriod("3 months rolling")
    #@filter.setPeriod("Year to date")
    #@filter.setPeriod("Week")
    #@filter.setPeriod("Day")
    @filter.setPeriod("Year to date")
    
    
    
=begin
    #@filter.setYear("2018")
    #@filter.setYear("2017")
    #@filter.setYear("2016")
    #@filter.setYear("2015")
    @filter.setYear("2017")
    @filter.setMonth("December")
    #@filter.setMonth("November")
    #@filter.setMonth("October")
    #@filter.setMonth("September")
    #@filter.setMonth("August")
    #@filter.setMonth("July")
    #@filter.setMonth("June")
    #@filter.setMonth("May")
    #@filter.setMonth("April")
    #@filter.setMonth("March")
    #@filter.setMonth("February")
    #@filter.setMonth("January")
    #@filter.setMonth("October")
=end



    #@filter.setBrand("MINI")
    #@filter.setBrand("ALL")
    #@filter.setBrand("BMW")
    #@filter.setBrand("BMW Motorrad")
    #@filter.setBrand("BMW i")
    @filter.setBrand("BMW")

    #@filter.setTouchpoint("New Car Sales")
    #@filter.setTouchpoint("Used Car Sales")
    #@filter.setTouchpoint("Service")
    #@filter.setTouchpoint("Roadside Assistance")
    @filter.setTouchpoint("New Car Sales")

    #@filter.setNPS_groups([ "Promoter" ])
    #@filter.setNPS_groups([ "Detractor", "Promoter" ])
    #@filter.setNPS_groups([ "Detractor", "Neutral" ])
    #@filter.setNPS_groups([ "Neutral", "Promoter" ])
    #@filter.setNPS_groups([ "Detractor" ])
    #@filter.setNPS_groups([ "Neutral" ])
    @filter.setNPS_groups([ "Detractor", "Neutral", "Promoter" ])
    
    puts @filter
    
    
    
    #sleep 3
    
    
    
    logout_from_portal

  end
#=end
  
end  




