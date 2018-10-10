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
    
    
    
    browser = @@b
    xpath   = "//div[@id='content-wrapper']/div/div[@id='feedback-table']/div[@id='feedback-table-panel']/div[contains(@class, 'panel-body')]/div[@id='adv-feedback-table']/table"

    @table = CTable.new(browser, xpath)

    
    
    puts @table
    
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



    #@@b.link(:xpath, "//a[contains(@href, '#page-19')]").click
    
    #sleep 6



    #puts @table.getNumCols

    #puts "--------------------------------------------------------------"
    
    #puts @table.getNumRowsVisible
    
    #puts "--------------------------------------------------------------"

    #start_timer_getRowsVisible = Time.now

    #puts @table.getRowsVisible

    #end_timer_getRowsVisible = Time.now
    
    #puts "getRowsVisible - duration: #{end_timer_getRowsVisible - start_timer_getRowsVisible}"
    
    #puts "--------------------------------------------------------------"

    #start_timer_getRowsVisible = Time.now

    #puts @table.getRowsVisible(5, 5, 5)

    #end_timer_getRowsVisible = Time.now
    
    #puts "getRowsVisible - duration: #{end_timer_getRowsVisible - start_timer_getRowsVisible}"
    
    #puts "--------------------------------------------------------------"

    #start_timer_getRowsVisible = Time.now

    #puts @table.getRowsVisible[2]

    #end_timer_getRowsVisible = Time.now
    
    #puts "getRowsVisible - duration: #{end_timer_getRowsVisible - start_timer_getRowsVisible}"
    
    #puts "--------------------------------------------------------------"

    #puts @table.getRow(2)

    #puts "--------------------------------------------------------------"



    puts @table.getColHeader
    
    puts "--------------------------------------------------------------"
    
    
    
    xpath = "//div[@id='content-wrapper']/div/div[@id='feedback-table']/div[@id='feedback-table-panel']/div[contains(@class, 'collapse in panel-tools')]/div/div/div[3]/div"

    @results_per_page = CResultsPerPage.new(browser, xpath, @table)

    
    
    puts @results_per_page
    
    puts "--------------------------------------------------------------"



    #start_timer_getRowsVisible = Time.now

    #puts @table.getRowsVisible

    #end_timer_getRowsVisible = Time.now
    
    #puts "getRowsVisible - duration: #{end_timer_getRowsVisible - start_timer_getRowsVisible}"
    
    #puts "--------------------------------------------------------------"
    
    
    
    @results_per_page.setNumRows(25)



    @results_per_page.getNumSelected
    
    puts @results_per_page
    
    puts "--------------------------------------------------------------"



    #start_timer_getRowsVisible = Time.now

    #puts @table.getRowsVisible

    #end_timer_getRowsVisible = Time.now
    
    #puts "getRowsVisible - duration: #{end_timer_getRowsVisible - start_timer_getRowsVisible}"
    
    #puts "--------------------------------------------------------------"
    
    
    
    #@results_per_page.setNumRows(50)



    #@results_per_page.getNumSelected
    
    #puts @results_per_page
    
    #puts "--------------------------------------------------------------"



    #start_timer_getRowsVisible = Time.now

    #puts @table.getRowsVisible

    #end_timer_getRowsVisible = Time.now
    
    #puts "getRowsVisible - duration: #{end_timer_getRowsVisible - start_timer_getRowsVisible}"
    
    #puts "--------------------------------------------------------------"
    
    
    
    #@results_per_page.setNumRows(100)



    #@results_per_page.getNumSelected
    
    #puts @results_per_page
    
    #puts "--------------------------------------------------------------"



    #start_timer_getRowsVisible = Time.now

    #puts @table.getRowsVisible
    
    #end_timer_getRowsVisible = Time.now
    
    #puts "getRowsVisible - duration: #{end_timer_getRowsVisible - start_timer_getRowsVisible}"
    
    #puts "--------------------------------------------------------------"
    
    
    
    #@results_per_page.setNumRows(100)
    
    #puts @results_per_page
    
    #puts "--------------------------------------------------------------"
    
    
    
    #@results_per_page.setNumRows(25)
    
    #puts @results_per_page
    
    #puts "--------------------------------------------------------------"
    
    
    
    #@results_per_page.setNumRows(50)
    
    #puts @results_per_page
    
    #puts "--------------------------------------------------------------"
    
    
    
    #@results_per_page.setNumRows(10)
    
    #puts @results_per_page
    
    #puts "--------------------------------------------------------------"





    xpath = "//div[@id='content-wrapper']/div/div[@id='feedback-table']/div[@id='feedback-table-panel']/div[contains(@class, 'collapse in panel-tools')]/div/div/div[1]/form"

    @interview_filters = CInterviewFilters.new(browser, xpath, @table)

    
    
    puts @interview_filters
    
    puts "--------------------------------------------------------------"
    
    
    
    
    
    puts "Number of filters: #{@interview_filters.getNumFilters}"
    puts "Filter titles:     #{@interview_filters.getFilterTitles}"
    
    puts "--------------------------------------------------------------"



    @interview_filters.elem_filters.divs[0].input.click
    
    puts @interview_filters.getFilterStatus  

    puts @interview_filters


    @interview_filters.elem_filters.divs[1].input.click
    
    puts @interview_filters.getFilterStatus  

    puts @interview_filters
    


    #@interview_filters.elem_filters.divs[2].input.click
    
    #puts @interview_filters.getFilterStatus  

    #puts @interview_filters



    puts @interview_filters.getFilterStatus(0)  

    puts @interview_filters



    puts @interview_filters.getFilterStatus(1)  

    puts @interview_filters



    #puts @interview_filters.getFilterStatus(2)  

    #puts @interview_filters



    puts "CInterviewFilters::enableFilter"
    puts @interview_filters.enableFilter

    puts @interview_filters



    puts "CInterviewFilters::disableFilter"
    puts @interview_filters.disableFilter

    puts @interview_filters



    puts "CInterviewFilters::enableFilter(1)"
    puts @interview_filters.enableFilter(1)

    puts @interview_filters



    puts "CInterviewFilters::disableFilter(1)"
    puts @interview_filters.disableFilter(1)

    puts @interview_filters



    xpath = "//div[@id='content-wrapper']/div/div[@id='feedback-table']/div[@id='feedback-table-panel']/div[contains(@class, 'panel-body')]/div[@id='adv-feedback-table']/nav[@id='pagination']"

    @pagination = CPagination.new(browser, xpath, @table)

    
    
    puts @pagination
    
    puts "--------------------------------------------------------------"
    
    
    
    @pagination.selectNextPage
    
    puts @pagination
    
    puts "--------------------------------------------------------------"
    
    
    
    @pagination.selectNextPage
    
    puts @pagination
    
    puts "--------------------------------------------------------------"
    
    
    
    @pagination.selectPrevPage
    
    puts @pagination
    
    puts "--------------------------------------------------------------"
    
    
    
    @pagination.selectPrevPage
    
    puts @pagination
    
    puts "--------------------------------------------------------------"
    
    
    
    @pagination.selectPrevPage
    
    puts @pagination
    
    puts "--------------------------------------------------------------"
    
    
    
    @pagination.selectPage(19)
    
    puts @pagination
    
    puts "--------------------------------------------------------------"
    
    
    
    @pagination.selectPrevPage
    
    puts @pagination
    
    puts "--------------------------------------------------------------"
    
    
    
    @pagination.selectNextPage
    
    puts @pagination
    
    puts "--------------------------------------------------------------"
    
    
    
=begin
    @pagination.selectNextPage
    
    puts @pagination
    
    puts "--------------------------------------------------------------"
    
    
    
    @pagination.selectPage(19)
    
    puts @pagination
    
    puts "--------------------------------------------------------------"
     
    
    
    @pagination.selectPage(17)
    
    puts @pagination
    
    puts "--------------------------------------------------------------"
    
    
    
    @pagination.selectPage(15)
    
    puts @pagination
    
    puts "--------------------------------------------------------------"
    
    
    
    @pagination.selectPage(13)
    
    puts @pagination
    
    puts "--------------------------------------------------------------"
    
    
    
    @pagination.selectPage(11)
    
    puts @pagination
    
    puts "--------------------------------------------------------------"
    
    
    
    @pagination.selectPage(9)
    
    puts @pagination
    
    puts "--------------------------------------------------------------"
    
    
    
    @pagination.selectPage(7)
    
    puts @pagination
    
    puts "--------------------------------------------------------------"
    
    
    
    @pagination.selectPage(5)
    
    puts @pagination
    
    puts "--------------------------------------------------------------"
    
    
    
    @pagination.selectPage(7)
    
    puts @pagination
    
    puts "--------------------------------------------------------------"
    
    
    
    @pagination.selectPage(9)
    
    puts @pagination
    
    puts "--------------------------------------------------------------"
    
    
    
    @pagination.selectPage(11)
    
    puts @pagination
    
    puts "--------------------------------------------------------------"
    
    
    
    @pagination.selectPage(13)
    
    puts @pagination
    
    puts "--------------------------------------------------------------"
    
    
    
    @pagination.selectPage(15)
    
    puts @pagination
    
    puts "--------------------------------------------------------------"
    
    
    
    @pagination.selectPage(17)
    
    puts @pagination
    
    puts "--------------------------------------------------------------"
    
    
    
    @pagination.selectPage(16)
    
    puts @pagination
    
    puts "--------------------------------------------------------------"
    
    
    
    @pagination.selectPage(14)
    
    puts @pagination
    
    puts "--------------------------------------------------------------"
    
    
    
    @pagination.selectPage(12)
    
    puts @pagination
    
    puts "--------------------------------------------------------------"
    
    
    
    @pagination.selectPage(10)
    
    puts @pagination
    
    puts "--------------------------------------------------------------"
    
    
    
    @pagination.selectPage(8)
    
    puts @pagination
    
    puts "--------------------------------------------------------------"
    
    
    
    @pagination.selectPage(6)
    
    puts @pagination
    
    puts "--------------------------------------------------------------"
    
    
    
    @pagination.selectPage(3)
    
    puts @pagination
    
    puts "--------------------------------------------------------------"
    
    
    
    @pagination.selectPage(4)
    
    puts @pagination
    
    puts "--------------------------------------------------------------"
    
    
    
    @pagination.selectPage(5)
    
    puts @pagination
    
    puts "--------------------------------------------------------------"
    
    
    
    @pagination.selectPage(6)
    
    puts @pagination
    
    puts "--------------------------------------------------------------"
    
    
    
    @pagination.selectPage(1)
    
    puts @pagination
    
    puts "--------------------------------------------------------------"
=end
    
    
    
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




