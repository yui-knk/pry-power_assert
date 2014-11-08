require "pry"
require "power_assert"
require "pry-power_assert/version"

module PryPowerAssert
  Pry::Commands.create_command('pa', '') do

    banner <<-'BANNER'
      Usage: pa RUBY_CODE

      The pa command show RUBY_CODE result with power_assert like format.

      [1] pry(main)> pa "0".class == "3".to_i.times.map {|i| i + 1 }.class
      result: false

      "0".class == "3".to_i.times.map {|i| i + 1 }.class
          |     |      |    |     |                |
          |     |      |    |     |                Array
          |     |      |    |     [1, 2, 3]
          |     |      |    #<Enumerator: 3:times>
          |     |      3
          |     false
          String
    BANNER

    def process
      result = "result: "

      PowerAssert.start(arg_string, source_binding: context[:target]) do |pa|
        result << pa.yield.inspect << "\n\n"
        result << pa.message_proc.()
      end

      output.puts result
    end

  end
end
