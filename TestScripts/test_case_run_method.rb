module Test
  module Unit
    class TestCase

      alias :old_run :run
      def run(result, &progress_block)

        #puts "TestCase.run: self.size: #{self.size}\n"

        old_run(result, &progress_block)

        File.open(File.dirname(__FILE__) + '/' + 'Logs' + '/' + 'errors.log', 'a+'){|f|
          result.failures.each{|err|
            case err
              when Test::Unit::Error, Test::Unit::Failure
                f << "err.test_name:\n#{err.test_name}\n"
                #f << "err:\n#{err}\n"
                f << "err.location:\n#{err.location}\n"
                f << "err.method_name:\n#{err.method_name}\n"
                f << "err.message:\n#{err.message}\n"
                f << "err.long_display:\n#{err.long_display}\n"
                #f << "err.short_display:\n#{err.short_display}\n"
              #not in log file
              when Test::Unit::Pending, Test::Unit::Notification, Test::Unit::Omission
            end
          }
        }

=begin
        time = Time.new
        File.open(File.dirname(__FILE__) + '/' + 'Logs' + '/' + 'errors.log', 'a+'){|f|
          f << File.dirname(__FILE__) + '/' + 'Screenshot' + '_' + "[#{self.class.to_s}" + '#' + "#{__method__.to_s}]" + '_' + time.strftime('%Y%m%d_%H%M%S') + '.png' + "\n"
        }
=end

      end
    end
  end
end
