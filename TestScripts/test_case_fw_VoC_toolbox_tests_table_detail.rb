#Encoding: UTF-8
puts "Test: ÄÖÜäöüß\n" 

puts "#{Time.new.strftime('%Y.%m.%d %H:%M:%S')} - START TESTING . . .\n"

require "./test_base_fw_VoC"

require "./test_case_fw_VoC_toolbox_module"



class TestExample

# Tested: 20180808 OK
#=begin
  def test_voc_issue_management_dashboard
    browse_to_new_project

    login_to_portal("ttr_support", "#F3nst3r")

    refresh_home_page



    @message = "'VoC - link Issue Management Dashboard' exists?"
    load_link_assert(@timeout_error_length, "link", "xpath", "//a[contains(@href, '/advancedFeedback/index')]")

    @message = "'VoC - link Issue Management Dashboard text=Issue Management Dashboard' exists?"
    load_link_assert(@timeout_error_length, "link", "xpath", "//a[contains(@href, '/advancedFeedback/index') and contains(text(),'Issue Management Dashboard')]")
    
    
    
=begin    
    browser    = @@b
    org_unit   = "Netherlands"
    period     = "12 months rolling"
    year       = "2018" 
    month      = "February"
    brand      = "ALL" 
    touchpoint = "ALL"
    nps_groups = [ "Detractor", "Neutral", "Promoter" ]

    @filter = CFilter.new(browser, org_unit, period, year, month, brand, touchpoint)
    
    puts @filter
    
    @filter.setOrgUnit(["Netherlands"])
    
    @filter.setPeriod("12 months rolling")
    
    puts @filter
=end
    
    
    
    browser = @@b
    xpath   = "//div[@id='content-wrapper']/div/div[@id='feedback-table']/div[@id='feedback-table-panel']/div[contains(@class, 'panel-body')]/div[@id='adv-feedback-table']/table"

    @table = CTable.new(browser, xpath)

    
    
    puts @table
    
    puts "--------------------------------------------------------------"
    
    
    
    xpath = "//div[@id='content-wrapper']/div/div[@id='feedback-table']/div[@id='feedback-table-panel']/div[contains(@class, 'collapse in panel-tools')]/div/div/div[3]/div"

    @results_per_page = CResultsPerPage.new(browser, xpath, @table)

    
    
    puts @results_per_page
    
    puts "--------------------------------------------------------------"
    
    
    
    @results_per_page.setNumRows(100)



    @results_per_page.getNumSelected
    
    puts @results_per_page
    
    puts "--------------------------------------------------------------"    
    
    
    
    start_timer_getNumCols = Time.now
    
    puts @table.getNumCols

    end_timer_getNumCols = Time.now
    
    puts "getNumCols - duration: #{end_timer_getNumCols - start_timer_getNumCols}"
    
    puts "--------------------------------------------------------------"

    start_timer_getNumRowsVisible = Time.now

    puts @table.getNumRowsVisible

    end_timer_getNumRowsVisible = Time.now
    
    puts "getNumRowsVisible - duration: #{end_timer_getNumRowsVisible - start_timer_getNumRowsVisible}"

    puts "--------------------------------------------------------------"



    #start_timer_getRowsVisible = Time.now

    #puts @table.getRowsVisible

    #end_timer_getRowsVisible = Time.now
    
    #puts "getRowsVisible - duration: #{end_timer_getRowsVisible - start_timer_getRowsVisible}"
    
    #puts "--------------------------------------------------------------"



    #puts @table.getColHeader
    
    #puts "--------------------------------------------------------------"
    
    
    
    @table_trs = @table.getRowsNode
    
    puts "--------------------------------------------------------------"



    if not @table_trs.nil?
    
      (0..[@table_trs.size-1,10].min).each do |i|
      
        start_timer_td = Time.now

        @table_trs[i].td.click
        
        #sleep 3
        
        #@table.browser.div(:xpath, @table.xpath + "/../div[contains(@class, 'loader')]").wait_while_present if i % 3 == 1

        #while @table.browser.div(:xpath, @table.xpath + "/../div[contains(@class, 'loader')]").exists?
        #end if i % 3 == 2
        
        #@table.browser.div(:xpath, "//div[@id='feedbackDetailModal' and not(@class='modal fade')]").wait_until_present if i % 3 == 0
        
        @table.browser.div(:xpath, "//div[@id='feedbackDetailModal' and not(@class='modal fade')]").wait_until_present         
        
        end_timer_td = Time.now
        
        puts "table detail - duration: #{end_timer_td - start_timer_td}"
        


        xpath = "//div[@id='feedbackDetailModal']"

        @interview_detail = CInterviewDetail.new(browser, xpath, @table)
        
        puts @interview_detail
        
        puts "\n"
        puts "--------------------------------------------------------------"

        puts "Header Title      = >#{@interview_detail.getHeaderTitle}<"
        puts "Header Close      = >#{@interview_detail.getHeaderClose}<"
        puts "Header Close text = >#{@interview_detail.getHeaderClose.text}<"

        puts "Body Title     = >#{@interview_detail.getBodyTitle}<"

        puts "Footer Buttons = >#{@interview_detail.getFooterButtons}<"
        
        @footer_buttons = @interview_detail.getFooterButtons
        
        (0..@footer_buttons.size-1).each do |i|
          puts "Footer Button[#{i}] text = >#{@footer_buttons[i].text}<" 
        end
        
        
        
        puts "Header XPath                           = >#{@interview_detail.getHeaderXPath}<"
        puts "Body XPath                             = >#{@interview_detail.getBodyXPath}<"
        puts "Body Title XPath                       = >#{@interview_detail.getBodyTitleXPath}<"
        puts "Navigation                             = >#{@interview_detail.getNavigationElement}<"
        puts "Navigation XPath                       = >#{@interview_detail.getNavigationElementXPath}<"
        puts "Navigation Buttons                     = >#{@interview_detail.getNavigationButtons}<"
        puts "Navigation Buttons XPath               = >#{@interview_detail.getNavigationButtonsXPath}<"
        puts "Alert                                  = >#{@interview_detail.getAlertElement}<"
        puts "Alert XPath                            = >#{@interview_detail.getAlertElementXPath}<"
        puts "Alert Lines                            = >#{@interview_detail.getAlertLines}<"
        puts "Alert Lines XPath                      = >#{@interview_detail.getAlertLinesXPath}<"
        puts "Alert Lines Text                       = >#{@interview_detail.getAlertLinesText}<"
        puts "Alert Lines Symbol                     = >#{@interview_detail.getAlertLinesSymbol}<"
        puts "Detail Data                            = >#{@interview_detail.getDetailDataTables}<"
        puts "Detail Data XPath                      = >#{@interview_detail.getDetailDataTablesXPath}<"
        puts "Detail Data Tabs                       = >#{@interview_detail.getDetailDataTabs}<"
        puts "Detail Data Tabs XPath                 = >#{@interview_detail.getDetailDataTabsXPath}<"
        puts "Detail Data Tabs Attrs                 = >#{@interview_detail.getDetailDataTabsAttrs}<"
        puts "Detail Data Tabs Links                 = >#{@interview_detail.getDetailDataTabsLinks}<"
        puts "Detail Data Tabs Captions              = >#{@interview_detail.getDetailDataTabsCaptions}<"
        puts "Detail Data Tabs Captions              = >#{@interview_detail.getDetailDataTabsCaptions_}<"
        puts "Detail Data Tabs Contents              = >#{@interview_detail.getDetailDataTabsContents}<"
        puts "Detail Data Tabs Contents XPath        = >#{@interview_detail.getDetailDataTabsContentsXPath}<"
        puts "Detail Data Tabs Contents Tables       = >#{@interview_detail.getDetailDataTabsContentsTables}<"
        puts "Detail Data Tabs Contents Tables XPath = >#{@interview_detail.getDetailDataTabsContentsTablesXPath}<"
        






        
        
        puts "Footer XPath                           = >#{@interview_detail.getFooterXPath}<"
        puts "Footer Buttons XPath                   = >#{@interview_detail.getFooterButtonsXPath}<"
        puts "Footer Buttons                         = >#{@interview_detail.getFooterButtons}<"
        puts "Footer Buttons Text                    = >#{@interview_detail.getFooterButtonsText}<"
        puts "Footer Links XPath                     = >#{@interview_detail.getFooterLinksXPath}<"
        puts "Footer Links                           = >#{@interview_detail.getFooterLinks}<"
        puts "Footer Links Text                      = >#{@interview_detail.getFooterLinksText}<"



        puts "--------------------------------------------------------------"
        puts "\n"



=begin
        @interview_detail.getDetailDataTables.each do |table|
          @detail_table = CTable.new(browser, nil, table)
          
          puts @detail_table
          


          start_timer_getNumCols = Time.now
          
          puts @detail_table.getNumCols
      
          end_timer_getNumCols = Time.now
          
          puts "getNumCols - duration: #{end_timer_getNumCols - start_timer_getNumCols}"
         


          start_timer_getNumRowsVisible = Time.now
      
          puts @detail_table.getNumRowsVisible
      
          end_timer_getNumRowsVisible = Time.now
          
          puts "getNumRowsVisible - duration: #{end_timer_getNumRowsVisible - start_timer_getNumRowsVisible}"
      
      

          start_timer_getRowsVisible = Time.now
      
          puts @detail_table.getRowsVisible
      
          end_timer_getRowsVisible = Time.now
          
          puts "getRowsVisible - duration: #{end_timer_getRowsVisible - start_timer_getRowsVisible}"
      


          puts "getColHeader: #{@detail_table.getColHeader}"

          puts "--------------------------------------------------------------"
          puts "\n"

        end
=end



=begin
        @interview_detail.getDetailDataTabsContentsTables.each do |table|
          @detail_tabs_contents_table = CTable.new(browser, nil, table)
          
          puts @detail_tabs_contents_table
          


          start_timer_getNumCols = Time.now
          
          puts @detail_tabs_contents_table.getNumCols
      
          end_timer_getNumCols = Time.now
          
          puts "getNumCols - duration: #{end_timer_getNumCols - start_timer_getNumCols}"
         


          start_timer_getNumRowsVisible = Time.now
      
          puts @detail_tabs_contents_table.getNumRowsVisible
      
          end_timer_getNumRowsVisible = Time.now
          
          puts "getNumRowsVisible - duration: #{end_timer_getNumRowsVisible - start_timer_getNumRowsVisible}"
      
      

          start_timer_getRowsVisible = Time.now
      
          puts @detail_tabs_contents_table.getRowsVisible
      
          end_timer_getRowsVisible = Time.now
          
          puts "getRowsVisible - duration: #{end_timer_getRowsVisible - start_timer_getRowsVisible}"
      


          puts "getColHeader: #{@detail_tabs_contents_table.getColHeader}"

          puts "--------------------------------------------------------------"
          puts "\n"

          @interview_detail.getDetailDataTabs[-1].link.click
          
          sleep 1
        end
=end






















        puts "--------------------------------------------------------------"
        puts "\n"

        #@table.browser.button(:xpath, "//div[@id='feedbackDetailModal']/div/div/div/button").click
        
        @interview_detail.getHeaderClose.click
        
        sleep 1
      
      end
      
      
      
=begin
      start_timer_td = Time.now

      @table_trs[4].td.click
      
      @table.browser.div(:xpath, "//div[@id='feedbackDetailModal' and not(@class='modal fade')]").wait_until_present         
      
      end_timer_td = Time.now
      
      puts "table detail - duration: #{end_timer_td - start_timer_td}"
      


      xpath = "//div[@id='feedbackDetailModal']"

      @interview_detail = CInterviewDetail.new(browser, xpath, @table)
      
      puts @interview_detail
      
      puts "\n"
      puts "--------------------------------------------------------------"

      puts "Header Title      = >#{@interview_detail.getHeaderTitle}<"
      puts "Header Close      = >#{@interview_detail.getHeaderClose}<"
      puts "Header Close text = >#{@interview_detail.getHeaderClose.text}<"

      puts "Body Title     = >#{@interview_detail.getBodyTitle}<"

      puts "Footer Buttons = >#{@interview_detail.getFooterButtons}<"
      
      @footer_buttons = @interview_detail.getFooterButtons
      
      (0..@footer_buttons.size-1).each do |i|
        puts "Footer Button[#{i}] text = >#{@footer_buttons[i].text}<" 
      end
      
      
      
      puts "Header XPath             = >#{@interview_detail.getHeaderXPath}<"
      puts "Body XPath               = >#{@interview_detail.getBodyXPath}<"
      puts "Body Title XPath         = >#{@interview_detail.getBodyTitleXPath}<"
      puts "Navigation               = >#{@interview_detail.getNavigationElement}<"
      puts "Navigation XPath         = >#{@interview_detail.getNavigationElementXPath}<"
      puts "Navigation Buttons       = >#{@interview_detail.getNavigationButtons}<"
      puts "Navigation Buttons XPath = >#{@interview_detail.getNavigationButtonsXPath}<"
      puts "Alert                    = >#{@interview_detail.getAlertElement}<"
      puts "Alert XPath              = >#{@interview_detail.getAlertElementXPath}<"
      puts "Footer XPath             = >#{@interview_detail.getFooterXPath}<"
      puts "Footer Buttons XPath     = >#{@interview_detail.getFooterButtonsXPath}<"
      puts "Footer Buttons           = >#{@interview_detail.getFooterButtons}<"
      puts "Footer Buttons Text      = >#{@interview_detail.getFooterButtonsText}<"
      puts "Footer Links XPath       = >#{@interview_detail.getFooterLinksXPath}<"
      puts "Footer Links             = >#{@interview_detail.getFooterLinks}<"
      puts "Footer Links Text        = >#{@interview_detail.getFooterLinksText}<"



      puts "--------------------------------------------------------------"
      puts "\n"
      
      
      
      @interview_detail.nextDetailView

      @interview_detail.nextDetailView

      @interview_detail.nextDetailView

      @interview_detail.nextDetailView

      @interview_detail.nextDetailView

      @interview_detail.nextDetailView

      @interview_detail.nextDetailView

      @interview_detail.nextDetailView

      @interview_detail.previousDetailView

      @interview_detail.previousDetailView

      @interview_detail.previousDetailView

      @interview_detail.previousDetailView

      @interview_detail.previousDetailView

      @interview_detail.previousDetailView
      
      
      
      xpath = "//div[@id='feedbackDetailModal']"

      @interview_detail = CInterviewDetail.new(browser, xpath, @table)
      
      puts @interview_detail
      
      puts "\n"
      puts "--------------------------------------------------------------"

      puts "Header Title      = >#{@interview_detail.getHeaderTitle}<"
      puts "Header Close      = >#{@interview_detail.getHeaderClose}<"
      puts "Header Close text = >#{@interview_detail.getHeaderClose.text}<"

      puts "Body Title     = >#{@interview_detail.getBodyTitle}<"

      puts "Footer Buttons = >#{@interview_detail.getFooterButtons}<"
      
      @footer_buttons = @interview_detail.getFooterButtons
      
      (0..@footer_buttons.size-1).each do |i|
        puts "Footer Button[#{i}] text = >#{@footer_buttons[i].text}<" 
      end
      
      
      
      puts "Header XPath             = >#{@interview_detail.getHeaderXPath}<"
      puts "Body XPath               = >#{@interview_detail.getBodyXPath}<"
      puts "Body Title XPath         = >#{@interview_detail.getBodyTitleXPath}<"
      puts "Navigation               = >#{@interview_detail.getNavigationElement}<"
      puts "Navigation XPath         = >#{@interview_detail.getNavigationElementXPath}<"
      puts "Navigation Buttons       = >#{@interview_detail.getNavigationButtons}<"
      puts "Navigation Buttons XPath = >#{@interview_detail.getNavigationButtonsXPath}<"
      puts "Alert                    = >#{@interview_detail.getAlertElement}<"
      puts "Alert XPath              = >#{@interview_detail.getAlertElementXPath}<"
      puts "Footer XPath             = >#{@interview_detail.getFooterXPath}<"
      puts "Footer Buttons XPath     = >#{@interview_detail.getFooterButtonsXPath}<"
      puts "Footer Buttons           = >#{@interview_detail.getFooterButtons}<"
      puts "Footer Buttons Text      = >#{@interview_detail.getFooterButtonsText}<"
      puts "Footer Links XPath       = >#{@interview_detail.getFooterLinksXPath}<"
      puts "Footer Links             = >#{@interview_detail.getFooterLinks}<"
      puts "Footer Links Text        = >#{@interview_detail.getFooterLinksText}<"



      puts "--------------------------------------------------------------"
      puts "\n"



      @interview_detail.getHeaderClose.click
      
      sleep 1
=end

    end
    
    
    
    logout_from_portal

  end
#=end
  
end  



