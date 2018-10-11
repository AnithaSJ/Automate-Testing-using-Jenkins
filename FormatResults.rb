require 'FileUtils'

class LogParser

	def initialize filePath
		raise ArgumentError unless File.exists?( filePath )
			@lines_array = IO.readlines(filePath)
	end

	def getResults
    outputFilePath = "D:/Software/jobs/PipelineTest_Watir/builds/"
    #Creates new file, if file exists overwrites the content
    outputFile = File.open(outputFilePath + "finalresults.txt", "w")


		outputFile.puts "-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
		outputFile.puts "Ruby Scripts Filepath                                                                                         ||                                  Output"
		outputFile.puts "-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"

		executedScripts_list = Array.new
		test_results = Array.new

		#Parse results.txt File
		[@lines_array, nil].flatten.each_cons(2) do |element, next_element|
				if (element =~ /ruby\.exe.+/ .. element  =~ /\.rb /)
						filename = element.match(/(?<=ruby\.exe)(.*)\.rb/) #Extracting only the Executed File Path
						executedScripts_list.push(filename)
						if (next_element =~ /ruby\.exe.+/) #if no output lines
								test_results.push("nil")
						elsif (next_element =~ /^(?!Number of Failures:.)/)#add immediate line into the array
								test_results.push(next_element)
						end
				elsif (element =~ /tests\,/ .. element  =~ /notifications/)
						output = element #Extracting only the Test restults
						test_results.push(output)
				end
		end
		executedScripts_list.each_with_index do |element, index|
			 outputFile.print element
			 outputFile.print "\t"+ "||" + "\t"
			 outputFile.puts test_results[index]
			 outputFile.puts "-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"

		end
	#	outputFile.puts "-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
		outputFile.puts "                                                                                ***************  End of File  ***************    " 
		outputFile.puts "-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"

		outputFile.close
		#Excel file
		workbook = RubyXL::Workbook.new
		#Customised file name based on log file creation DateTime
		log_creationTime = File.mtime("results.txt").to_s.split(" ")
		cdate = log_creationTime[0]
		ctime = log_creationTime[1].tr(':', '-')
		filename = "Feedback_Test" + cdate + "_" + ctime +".xlsx"

		##Important: Add/Modify cells in Sheets before .write method (creating excel file)
		worksheet = workbook[0]
		len = executedScripts_list.length

		#First row in sheet >>Add heading
		worksheet.add_cell(0, 0, "Test Scripts Filepath")
		worksheet.add_cell(0, 1, "Test Results")
		for i in 0..len
		  #(row number|colum number| value)
		  worksheet.add_cell(i+1, 0, executedScripts_list[i].to_s) #first column
		#	puts executedScripts_list[i]
		  worksheet.add_cell(i+1, 1, test_results[i]) #second column
		end
		col1_header_cell = worksheet[0][0]
		col2_header_cell = worksheet[0][1]

		col1_header_cell.change_font_bold(true)
		col2_header_cell.change_font_bold(true)
		#cell.fill_color
		col1_header_cell.change_fill('ffff00')
		col2_header_cell.change_fill('32cd32')
		#creates Excel named as filename
		workbook.write (filename)

		## TODO: rename a worksheet first Sheet1
		#workbook.worksheets[0].sheet_name = 'VW_VOC'
		
	end
end

buildPath = "D:/Software/jobs/PipelineTest_Watir/builds/"
Dir.chdir(buildPath)
#Obtain results from created results.txt file
pars = LogParser.new("results.txt")
pars.getResults
