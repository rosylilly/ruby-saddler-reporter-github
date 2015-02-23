require 'pathname'

module Saddler
  module Reporter
    module Github
      module Support
        def initialize(output)
          @output = output
        end

        def report(messages, _options)
          @output.puts messages
        end

        # {"checkstyle"=>
        #    {"file"=>
        #       [{"error"=>
        #           [{"@column"=>"4",
        #             "@line"=>"22",
        #             "@message"=>"Assignment Branch Condition size for report is too high. [34.34/15]",
        #             "@severity"=>"info",
        #             "@source"=>"com.puppycrawl.tools.checkstyle.Metrics/AbcSize"},
        #            {"@column"=>"4",
        #             "@line"=>"22",
        #             "@message"=>"Cyclomatic complexity for report is too high. [10/6]",
        #             "@severity"=>"info",
        #             "@source"=>"com.puppycrawl.tools.checkstyle.Metrics/CyclomaticComplexity"},
        #            {"@column"=>"6",
        #             "@line"=>"39",
        #             "@message"=>"Use space after control keywords.",
        #             "@severity"=>"info",
        #             "@source"=>"com.puppycrawl.tools.checkstyle.Style/SpaceAfterControlKeyword"}],
        #         "@name"=>"/Users/sane/work/ruby-study/saddler/lib/saddler/cli.rb"},
        #        {"@name"=>"/Users/sane/work/ruby-study/saddler/lib/saddler/reporter.rb"}]}}
        def parse(xml)
          Nori
            .new(parser: :rexml)
            .parse(xml)
        end

        def file_relative_path_string(file_name)
          if Pathname.new(file_name).absolute?
            Pathname.new(file_name).relative_path_from(Pathname.new(Dir.pwd)).to_s
          else
            Pathname.new(file_name).relative_path_from(Pathname.new('.')).to_s
          end
        end
      end
    end
  end
end
