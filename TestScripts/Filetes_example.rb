require 'FileUtils'

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
    outputFilePath = "D:/RubyExamples/VoC_scripts/JenkinsTest/"
    #Creates new file, if file exists overwrites the content
    outputFile = File.open(outputFilePath + "parsed.txt", "w")

		outputFile.puts "----------------------------------------------------------------------------------------------------------------------------------------------"
		outputFile.puts "Ruby Scripts Filepath                                                 | Output"
		outputFile.puts "----------------------------------------------------------------------------------------------------------------------------------------------"

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
			 outputFile.print "\s"+ "|" + "\s"
			 outputFile.puts test_results[index]
    end
    outputFile.close
	end
end

#buildPath = "D:/Software/jobs/PipelineTest_Watir/builds/"
#Dir.chdir(buildPath)
#latestFolder= Dir.glob("**/").max_by {|f| File.mtime(f)}
#logFile = buildPath + latestFolder
#Dir.chdir(logFile)
pars = LogParser.new("D:/RubyExamples/VoC_scripts/JenkinsTest/restults.txt")
pars.getResults
