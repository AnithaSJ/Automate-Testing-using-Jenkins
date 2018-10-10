require 'FileUtils'

class LogParser

	def initialize filePath
		raise ArgumentError unless File.exists?( filePath )
		@logFile	= File.read( filePath )
	end
  #Creates new file,if file exists appends the content
  #outputFile = File.open(outputFilePath + "results.txt", "a")

	#pull results of console log file form each line
	def getResults
    outputFilePath = "D:/Software/jobs/PipelineTest_Watir/builds/"
    #Creates new file, if file exists overwrites the content
    outputFile = File.open(outputFilePath + "results.txt", "w")
    puts outputFile
		@logFile.each_line do |line|
			if (line  =~ /ruby\.exe/ .. line  =~ /\.rb /) || (line  =~ /Number of Failures/ .. line  =~ /assertions\/s/)
        	outputFile.puts(line)
  		end
		end
    outputFile.close
	end
end

buildPath = "D:/Software/jobs/PipelineTest_Watir/builds/"
Dir.chdir(buildPath)
latestFolder= Dir.glob("**/").max_by {|f| File.mtime(f)}
logFile = buildPath + latestFolder
Dir.chdir(logFile)
pars = LogParser.new("log")
pars.getResults
