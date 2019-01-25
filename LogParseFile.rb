require 'rubyXL'
require 're'

class LogParser

	def initialize filePath
		raise ArgumentError unless File.exists?( filePath )
			@lines_array = IO.readlines(filePath) #read file line by line
	end

	def getResults outputPath, f_cdata

		#Calculate start and endline foreach Test_Script_File Output
		startline = Array.new
    endline = Array.new

		@lines_array.each_with_index do |element, index|
				if (not (element =~ /ruby\.exe.+/).nil?) # =~ returns position of expression match
					startline.push(index)
				end
				if (not (element =~ /assertions\/s/).nil?)
					endline.push(index + 1)
				end
		end

		test_suits= Array.new
    test_suits_results = Array.new
    length,i,j,line = 0
		#Multidimensional ARRAY
    #Array.new(Number_of_ROWs){Array.new(Number_of_COLUMNs){DefaultValues}}
    test_cases= Array.new(){Array.new(1){""}}
    test_cases_output= Array.new(){Array.new(1){""}}

		total_PASS_case,total_FAIL_case = 0

		is_exit = true

		#Store Test_Script_File names and Results (tests, errors....)
		@lines_array.each do |element|
			if (not (element =~ /Evaluate\.bat/).nil?)
				is_exit = false
			end
			if is_exit.is_a?(TrueClass) #control only to read Execute Scipts
		    if (not (element =~ /(.+)ruby\.exe(.+)\.rb/).nil?)
		 		  filename = element.match(/(?<=ruby\.exe).*\.rb/)
				  test_suits.push(filename) #Extracting only the Executed File Path
				elsif (not (element =~ /.+tests\,.*notifications/).nil?)
					output = element #Extracting only the Test restults
					test_suits_results.push(output)
				end
			end
		end

		#Foreach Test_Script_File extract Testcases(Test Method Names) and Testcases's output PASS/FAIL
		endline.each_with_index do |element, index|
			length = endline[index] - startline[index]
			line = startline[index]
			test_method = []
			test_method_outcome = []
			for j in 0..length + 1
				element = @lines_array[line + j]
				next_element =   @lines_array[line + j + 1]

				if (not (element =~ /TestExample\.teardown\:\ terminating/).nil?)
					test_method.push(element.match(/((?<=TestExample.teardown: terminating.)(.*)?\ )/))
				end
				if (not (next_element =~ /TestExample.teardown: FAIL/).nil?)
					test_method_outcome.push('FAIL')
					total_FAIL_case = total_FAIL_case.to_i + 1
				elsif (not (next_element =~ /TestExample.teardown: PASS/).nil?)
					test_method_outcome.push('PASS')
					total_PASS_case = total_PASS_case.to_i + 1
				end
			end
			test_cases.push(test_method)
			test_cases_output.push(test_method_outcome)
		end

		#Section: Result file generation
		#Customised file name based on log file creation DateTime
# 				log_creationTime = File.mtime("Test_results.txt").to_s.split(" ")
# 				cdate = log_creationTime[0]
# 				ctime = log_creationTime[1].tr(':', '-')
# 			  filename = "Feedback_Test" + cdate + "_" + ctime +".xlsx"
		excel_filename = "Feedback_Test" + f_cdata + ".xlsx"
		text_filename = "Feedback_Test" + f_cdata + ".txt"
		#Change directory to Output Path (build folder of Jenkins Pipeline)
		Dir.chdir(outputPath)

		#Create Text File
    #outputFilePath = "D:/Software/jobs/PipelineTest_Watir/builds/"
		#outputFile = File.open( outputFilePath +  "Test_results.txt", "w")
		outputFile = File.open(text_filename, "w")
		outputFile.puts "----------------------------------------------------------------------------------------------------------------------------------------------"
		outputFile.puts "TestSuits                                                 			|| Results"
		outputFile.puts "----------------------------------------------------------------------------------------------------------------------------------------------"

		test_suits.each_with_index do |element, index|
			 outputFile.print element
			 outputFile.print "\t"+ "||" + "\t"
			 outputFile.puts test_suits_results[index]
    end
		#outputFile.puts "----------------------------------------------------------------------------------------------------------------------------------------------"
		outputFile.puts "----------------------------------------------------------------------------------------------------------------------------------------------"
		outputFile.puts "TestCases                                                      || Output"
		outputFile.puts "----------------------------------------------------------------------------------------------------------------------------------------------"


		test_cases.each_with_index do |element, indexi|
			element.each_with_index do |value, indexj|
			 outputFile.print value
			 outputFile.print "\t"+ "||" + "\t"
			 outputFile.puts test_cases_output[indexi][indexj]
		 end
		end
		#outputFile.puts "----------------------------------------------------------------------------------------------------------------------------------------------"
		outputFile.puts "----------------------------------------------------------------------------------------------------------------------------------------------"
		outputFile.puts "                                                 *********    EOF    *********"
		outputFile.puts "----------------------------------------------------------------------------------------------------------------------------------------------"

    outputFile.close

		#Create Excel File
		#Dir.chdir(outputFilePath) # directory path for storing excel file
		workbook = RubyXL::Workbook.new
		#Important: Add/Modify cells in Sheets before .write method(.write--> creates excel file)
   				#worksheet = workbook[0] #EXCEL:Sheet1
					worksheet_Overview = workbook[0] #EXCEL:Sheet1
					worksheet_Detailed = workbook.add_worksheet('Sheet2')  #EXCEL:Sheet2

		#First row in sheet1 >>Add heading
  				worksheet_Overview.add_cell(0, 0, "TestSuits") #first column
  				worksheet_Overview.add_cell(0, 1, "Tests" ) #second column
  				worksheet_Overview.add_cell(0, 2, "Assertions" ) #third column
  				worksheet_Overview.add_cell(0, 3, "Failures")  #fourth column
  				worksheet_Overview.add_cell(0, 4, "Errors")  #fifth column
  				worksheet_Overview.add_cell(0, 5, "Pendings") #seventh column
  				worksheet_Overview.add_cell(0, 6, "Omissions") #eighth column
  				worksheet_Overview.add_cell(0, 7, "Notifications") #ninth column

		#Format Sheet1 column header
					col1_header_cell = worksheet_Overview[0][0]
					col2_header_cell = worksheet_Overview[0][1]
					col3_header_cell = worksheet_Overview[0][2]
					col4_header_cell = worksheet_Overview[0][3]
					col5_header_cell = worksheet_Overview[0][4]
					col6_header_cell = worksheet_Overview[0][5]
					col7_header_cell = worksheet_Overview[0][6]
					col8_header_cell = worksheet_Overview[0][7]

					col1_header_cell.change_font_bold(true)
					col2_header_cell.change_font_bold(true)
					col3_header_cell.change_font_bold(true)
					col4_header_cell.change_font_bold(true)
					col5_header_cell.change_font_bold(true)
					col6_header_cell.change_font_bold(true)
					col7_header_cell.change_font_bold(true)
					col8_header_cell.change_font_bold(true)

					#cell.fill_color
					col1_header_cell.change_fill('00FF00')
					col2_header_cell.change_fill('3697dd')
					col3_header_cell.change_fill('f0c800')
					col4_header_cell.change_fill('de1c24')
					col5_header_cell.change_fill('af3205')
					col6_header_cell.change_fill('9ba991')
					col7_header_cell.change_fill('c5e8d6')
					col8_header_cell.change_fill('8caa2d')

 		#First row in sheet2 >>Add heading
					worksheet_Detailed.add_cell(0, 0, "TestSuits") #first column
					worksheet_Detailed.add_cell(0, 1, "TestCases") #second column
					worksheet_Detailed.add_cell(0, 2, "Results") #third column

		#Format Sheet2 column header
					s2_col1_header_cell = worksheet_Detailed[0][0]
					s2_col2_header_cell = worksheet_Detailed[0][1]
					s2_col3_header_cell = worksheet_Detailed[0][2]
		#font change
					s2_col1_header_cell.change_font_bold(true)
					s2_col2_header_cell.change_font_bold(true)
					s2_col3_header_cell.change_font_bold(true)

    #cell.fill_color
					s2_col1_header_cell.change_fill('00FF00')
					s2_col2_header_cell.change_fill('0082c8')
					s2_col3_header_cell.change_fill('f0c800')


		#fill in Sheet1 --- TestSuits, Results-Tests, Assertions etc
				total_Test, total_As, total_Fail, total_Er, total_Pen, total_Om, total_Notf  = 0
				s1_row = 0
				test_suits.each_with_index do |script, indexi|
					#Parse Test_Script Results
					val = ""
					test_suits_results_str = test_suits_results[indexi].to_s
					#Split TestSuits Results
					test_suits_results_list = test_suits_results_str.split(",")
					val = /(\d+)/.match(test_suits_results_list[0])
					tests = val.to_s
					val = /\d+/.match(test_suits_results_list[1])
					assertions = val.to_s
					val = /\d+/.match(test_suits_results_list[2])
					failures = val.to_s
					val = /\d+/.match(test_suits_results_list[3])
					errors = val.to_s
					val = /\d+/.match(test_suits_results_list[4])
					pendings = val.to_s
					val = /\d+/.match(test_suits_results_list[5])
					omissions = val.to_s
					val = /\d+/.match(test_suits_results_list[6])
					notifications = val.to_s

					total_Test = total_Test.to_i + tests.to_i
					total_As = total_As.to_i + assertions.to_i
					total_Fail = total_Fail.to_i + failures.to_i
					total_Er = total_Er.to_i + errors.to_i
					total_Pen = total_Pen.to_i + pendings.to_i
					total_Om = total_Om.to_i + omissions.to_i
					total_Notf = total_Notf.to_i + notifications.to_i

					#(row number|colum number| value)
					worksheet_Overview.add_cell(s1_row + 1 , 0, script.to_s) #first column
					worksheet_Overview.add_cell(s1_row + 1 , 1, tests.to_s ) #second column
					worksheet_Overview.add_cell(s1_row + 1 , 2, assertions.to_s ) #third column
					worksheet_Overview.add_cell(s1_row + 1 , 3, failures.to_s) #fourth column
					worksheet_Overview.add_cell(s1_row + 1 , 4, errors.to_s) #fifth column
					worksheet_Overview.add_cell(s1_row + 1 , 5, pendings.to_s) #sixth column
					worksheet_Overview.add_cell(s1_row + 1 , 6, omissions.to_s) #seventh column
					worksheet_Overview.add_cell(s1_row + 1 , 7, notifications.to_s) #eighth column

					s1_row = s1_row + 1 #increment '#row'
				end

				#Sheet1 fill total of TestSuits results
				#(row number|colum number| value)
				worksheet_Overview.add_cell(s1_row + 2 , 1, total_Test.to_s ) #second column
				worksheet_Overview.add_cell(s1_row + 2 , 2, total_As.to_s ) #third column
				worksheet_Overview.add_cell(s1_row + 2 , 3, total_Fail.to_s) #fourth column
				worksheet_Overview.add_cell(s1_row + 2 , 4, total_Er.to_s) #fifth column
				worksheet_Overview.add_cell(s1_row + 2 , 5, total_Pen.to_s) #sixth column
				worksheet_Overview.add_cell(s1_row + 2 , 6, total_Om.to_s) #seventh column
				worksheet_Overview.add_cell(s1_row + 2 , 7, total_Notf.to_s) #eighth column

	#Fill in Sheet2 --- TestSuits, TestCases, test_cases_output

				s1_row = 0
				test_suits.each_with_index do |script, indexi|
					#(row number|colum number| value)
					worksheet_Detailed.add_cell(s1_row + 1 , 0, script.to_s) #first column --Test_Script

					#Fill--Test methods/cases and output
					if (not test_cases[indexi].nil?)
						#(row number|colum number| value)
						test_cases[indexi].each_with_index do |value,indexj|
								worksheet_Detailed.add_cell(s1_row + 1 , 0, script.to_s)#(Repeat Script name) First column
								worksheet_Detailed.add_cell(s1_row + 1 , 1, value.to_s) #second column
								worksheet_Detailed.add_cell(s1_row + 1 , 2, test_cases_output[0][indexj].to_s ) #third column
								s1_row = s1_row + 1
						end
					end
				end
				#Fill total of test_cases_output
				worksheet_Detailed.add_cell(s1_row + 2 , 2, "PASS") #PASS
				worksheet_Detailed.add_cell(s1_row + 3 , 2, "FAIL" ) #FAIL

				worksheet_Detailed.add_cell(s1_row + 2 , 3, total_PASS_case.to_s) #Number_of_PASS
				worksheet_Detailed.add_cell(s1_row + 3 , 3, total_FAIL_case.to_s ) #Number_of_FAIL

				#Format cell Number_of_PASS/FAIL
				pass_header_cell = worksheet_Detailed[s1_row + 2][2]
				fail_header_cell = worksheet_Detailed[s1_row + 3][2]
				pass_header_cell.change_font_bold(true)
				fail_header_cell.change_font_bold(true)

				pass_header_cell_value = worksheet_Detailed[s1_row + 2][3]
				fail_header_cell_value = worksheet_Detailed[s1_row + 3][3]
				pass_header_cell_value.change_fill('00FF00')
				fail_header_cell_value.change_fill('de1c24')

				var= workbook.write (excel_filename) #Write and create EXCEL
				puts("Results file generated list:")
				puts(var)
				puts(text_filename)

	end
end

#Redirect to the Jenkins build path of Pipeline ex-'PipelineTest_Watir'
buildPath = "D:/Software/jobs/TestPipeline_2019/builds/"
Dir.chdir(buildPath)
#latest build folder
latestFolder= Dir.glob("**/").max_by {|f| File.mtime(f)}
logFile = buildPath + latestFolder
Dir.chdir(logFile)
log_creationTime = File.mtime("log").to_s.split(" ")
cdate = log_creationTime[0]
ctime = log_creationTime[1].tr(':', '-')
cdata = cdate + "_" + ctime #Creation date and time of log file

if File.exist?("log")
	pars = LogParser.new("log")
	#pars.getResults(buildPath, cdata)
	pars.getResults(logFile, cdata)
else
	puts("Exceution history of latest build: log file not found")
end
