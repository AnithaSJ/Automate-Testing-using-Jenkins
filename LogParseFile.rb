#require 'FileUtils'
require 'rubyXL'
require 're'

class LogParser

	def initialize filePath
		raise ArgumentError unless File.exists?( filePath )
		#@logFile	= File.read( filePath )
		@lines_array = IO.readlines(filePath)
	end
  #Creates new file,if file exists appends the content
  #outputFile = File.open(outputFilePath + "results.txt", "a")

	#pull results of console log file form each line
	def getResults
  #  outputFilePath = "D:/RubyExamples/VoC_scripts/JenkinsTest/"
    #Creates new file, if file exists overwrites the content
  #  outputFile = File.open(outputFilePath + "LogFile_Results.txt", "w")
    outputFilePath = "D:/Software/jobs/PipelineTest_Watir/builds/"
		outputFile = File.open( outputFilePath +  "Test_results.txt", "w")
		outputFile.puts "----------------------------------------------------------------------------------------------------------------------------------------------"
		outputFile.puts "TestSuits                                                 || Results"
		outputFile.puts "----------------------------------------------------------------------------------------------------------------------------------------------"

		test_suits= Array.new
		test_suits_results = Array.new
		test_cases = Array.new
		test_cases_output = Array.new
		test_suits_results_list = []
		test_suits_results_str = ""

    #Parse results.txt File
		[@lines_array, nil].flatten.each_cons(2) do |element, next_element|

			    if (element =~ /ruby\.exe.+/ .. element  =~ /\.rb /)
			 		  filename = element.match(/(?<=ruby\.exe)(.*)\.rb/) #Extracting only the Executed File Path
					  test_suits.push(filename)

						if (next_element =~ /ruby\.exe.+/) #if no output lines
								test_suits_results.push("no results")
						#elsif (next_element =~ /^(?!Number of Failures:.)/)#add immediate line into the array
							#	test_suits_results.push(next_element)
						end
					elsif (element =~ /tests\,/ .. element  =~ /notifications/)
									output = element #Extracting only the Test restults
									test_suits_results.push(output)

					elsif (element =~ /TestExample\.teardown\:\ terminating/)
									test_cases.push(element.match(/(?<=TestExample.teardown: terminating.)(.*) ?\ /))
									#puts element.match(/(?<=TestExample.teardown: terminating.)(.*) ?\ /)
								  if (next_element =~ /TestExample.teardown: FAIL/  )
										test_cases_output.push("FAIL")
										#puts "F"
									else
										test_cases_output.push("PASS")
										#puts "P"
									end
					end
			end

=begin
						case
						when next_element.match(/ruby\.exe.+/)
							test_suits_results.push("Nil")
						when next_element.match(/^(?!Number of Failures:.)/)
								test_suits_results.push(next_element)
						end
=end
=begin
				case
				when element.match(/TestExample\.teardown\: terminating/)
						test_cases.push(element.match(/(?<=TestExample.teardown: terminating.)(.*) ?\ /))
						puts element.match(/(?<=TestExample.teardown: terminating.)(.*) ?\ /)
				when next_element.match(/TestExample\.teardown\: PASS/)
						test_cases_output.push("FAIL")
						puts next_element
				when next_element.match(/TestExample\.teardown\: PASS/)
						test_cases_output.push("PASS")
						puts next_element
				end
=end

		test_suits.each_with_index do |element, index|
			 outputFile.print element
			 outputFile.print "\t"+ "||" + "\t"
			 outputFile.puts test_suits_results[index]
    end
		#outputFile.puts "----------------------------------------------------------------------------------------------------------------------------------------------"
		outputFile.puts "----------------------------------------------------------------------------------------------------------------------------------------------"
		outputFile.puts "TestCases                                                 || Output"
		outputFile.puts "----------------------------------------------------------------------------------------------------------------------------------------------"


		test_cases.each_with_index do |element, index|
			 outputFile.print element
			 outputFile.print "\t"+ "||" + "\t"
			 outputFile.puts test_cases_output[index]
		end
		#outputFile.puts "----------------------------------------------------------------------------------------------------------------------------------------------"
		outputFile.puts "----------------------------------------------------------------------------------------------------------------------------------------------"
		outputFile.puts "                                                 *********    EOF    *********"
		outputFile.puts "----------------------------------------------------------------------------------------------------------------------------------------------"

    outputFile.close

		Dir.chdir(outputFilePath) # directory path for storing excel file

				workbook = RubyXL::Workbook.new
				#Customised file name based on log file creation DateTime
				log_creationTime = File.mtime("Test_results.txt").to_s.split(" ")
				cdate = log_creationTime[0]
				ctime = log_creationTime[1].tr(':', '-')
			  filename = "Feedback_Test" + cdate + "_" + ctime +".xlsx"
        #filename = "Feedback_Test" + ".xlsx"
				##Important: Add/Modify cells in Sheets before .write method (creating excel file)
				worksheet = workbook[0]
				worksheet_additional = workbook.add_worksheet('Sheet2')
				len = test_suits.length
				m_len = test_cases.length

				#First row in sheet1 >>Add heading
				worksheet.add_cell(0, 0, "TestSuits") #first column
				worksheet.add_cell(0, 1, "TestCases") #second column
				worksheet.add_cell(0, 2, "Results") #third column
				worksheet.add_cell(0, 3, "Tests" ) #fourth column
				worksheet.add_cell(0, 4, "Assertions" ) #fifth column
				worksheet.add_cell(0, 5, "Failures")  #sixth column
				worksheet.add_cell(0, 6, "Errors")  #seventh column
				worksheet.add_cell(0, 7, "Pendings") #eighth column
				worksheet.add_cell(0, 8, "Omissions") #ninth column
				worksheet.add_cell(0, 9, "Notifications") #tenth column

				#First row in sheet2 >>Add heading
				worksheet_additional.add_cell(0, 0, "TestCases")
				worksheet_additional.add_cell(0, 1, "Output")

				#Each TestCase parse output
				row = 1
			  for i in 0..len
					val = ""
				  row += 1 #Increment row
				 	test_suits_results_str = test_suits_results[i].to_s
					no_val = (test_suits_results_str =~ /no results/)

				  if no_val then
				  		 tests = "no results"
			    		 assertions = "no results"
				  		 failures = "no results"
				  		 errors = "no results"
				  		 pendings = "no results"
				  		 omissions = "no results"
				   		 notifications = "no results"
				  else
				 	#Split TestSuits Results
			 			 test_suits_results_list = test_suits_results_str.split(",")

						 val = /\d+/.match(test_suits_results_list[0])
						 tests = val

						 val = /\d+/.match(test_suits_results_list[1])
  		  		 assertions = val

						 val = /\d+/.match(test_suits_results_list[2])
						 failures = val

						 val = /\d+/.match(test_suits_results_list[3])
				 		 errors = val

						 val = /\d+/.match(test_suits_results_list[4])
			 	 		 pendings = val

						 val = /\d+/.match(test_suits_results_list[5])
				 		 omissions = val

						 val = /\d+/.match(test_suits_results_list[6])
		 	 		   notifications = val

			 		end
				# #puts(tests, assertions, failures, errors, pendings, omissions, notifications )

				# #(row number|colum number| value)
				   worksheet.add_cell(row , 0, test_suits[i].to_s) #first column
					 unless (test_cases[i]).to_s.empty?  #negativeIF
						 worksheet.add_cell(row , 1, test_cases[i].to_s) #second column
						 worksheet.add_cell(row , 2, test_cases_output[i].to_s) #third column
					 end
					# #	puts executedScripts_list[i]
				# worksheet.add_cell(i+1, 1, test_suits_results[i]) #second column
			     worksheet.add_cell(row , 3, tests.to_s ) #fourth column
			     worksheet.add_cell(row , 4, assertions.to_s ) #fifth column
			 	   worksheet.add_cell(row , 5, failures.to_s) #sixth column
				   worksheet.add_cell(row , 6, errors.to_s) #seventh column
			 	   worksheet.add_cell(row , 7, pendings.to_s) #eighth column
		 	     worksheet.add_cell(row , 8, omissions.to_s) #ninth column
		       worksheet.add_cell(row , 9, notifications.to_s) #tenth column

	        #  if !(test_cases[i]).to_s.empty?
					# 	  row =  row + 1#increment rows based on testcases
					# 	  #Test_cases and results per test_suits
					# 	 	worksheet.add_cell(row , 0, test_cases[i].to_s) #first column
					# 	 	worksheet.add_cell(row , 1, test_cases_output[i].to_s) #second column
          # end
        end
			  # col1_header_cell = worksheet[0][0]
			  # col2_header_cell = worksheet[0][1]
				#
				# col1_header_cell.change_font_bold(true)
				# col2_header_cell.change_font_bold(true)
				#cell.fill_color
				# col1_header_cell.change_fill('ffff00')
				# col2_header_cell.change_fill('32cd32')


			  col1_header_cell = worksheet[0][0]
			  col2_header_cell = worksheet[0][1]
				col3_header_cell = worksheet[0][2]
			  col4_header_cell = worksheet[0][3]
				col5_header_cell = worksheet[0][4]
			  col6_header_cell = worksheet[0][5]
				col7_header_cell = worksheet[0][6]
			  col8_header_cell = worksheet[0][7]
				col9_header_cell = worksheet[0][8]
				col10_header_cell = worksheet[0][9]
				#
				col1_header_cell.change_font_bold(true)
				col2_header_cell.change_font_bold(true)
				col3_header_cell.change_font_bold(true)
				col4_header_cell.change_font_bold(true)
				col5_header_cell.change_font_bold(true)
				col6_header_cell.change_font_bold(true)
				col7_header_cell.change_font_bold(true)
				col8_header_cell.change_font_bold(true)
				col9_header_cell.change_font_bold(true)
				col10_header_cell.change_font_bold(true)

				#cell.fill_color
				col1_header_cell.change_fill('ffff00')
				col2_header_cell.change_fill('32cd32')
				col3_header_cell.change_fill('ffff00')
				col4_header_cell.change_fill('32cd32')
				col5_header_cell.change_fill('ffff00')
				col6_header_cell.change_fill('32cd32')
				col7_header_cell.change_fill('ffff00')
				col8_header_cell.change_fill('32cd32')
				col9_header_cell.change_fill('ffff00')
				col10_header_cell.change_fill('32cd32')


				for i in 0..m_len
			   #(row number|colum number| value)
					 worksheet_additional.add_cell(i+1, 0, test_cases[i].to_s) #first column
					#	puts executedScripts_list[i]
					 worksheet_additional.add_cell(i+1, 1, test_cases_output[i].to_s) #second column
			  end
				col1_header_cell1 = worksheet_additional[0][0]
				col2_header_cell2 = worksheet_additional[0][1]
				#font change
				col1_header_cell1.change_font_bold(true)
				col2_header_cell2.change_font_bold(true)
				# #cell.fill_color
				col1_header_cell1.change_fill('ffff00')
				col2_header_cell2.change_fill('32cd32')

				#creates Excel named as filename
				var= workbook.write (filename)

				puts("Results file generated list:")
				puts(var)
				puts("Test_results.txt")

				## TODO: rename a worksheet first Sheet1
				#workbook.worksheets[0].sheet_name = 'VW_VOC'

	end
end
buildPath = "D:/Software/jobs/PipelineTest_Watir/builds/"
#buildPath = "D:/Software/jobs/Testexample/"
Dir.chdir(buildPath)
latestFolder= Dir.glob("**/").max_by {|f| File.mtime(f)}
logFile = buildPath + latestFolder
Dir.chdir(logFile)
#Dir.chdir("D:/RubyExamples/VoC_scripts/JenkinsTest/")

if File.exist?("log")
	pars = LogParser.new("log")
	pars.getResults
else
	puts("Exceution history of latest build: log file not found")
end
