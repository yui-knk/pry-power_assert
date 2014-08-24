require "pry"
require "pry-power_assert/version"
require "pry-power_assert/power_assert-ext"

module PryPowerAssert
  class PowerAssertCommand < Pry::ClassCommand
    match 'pa'
    group 'Misc'
    description ''

    banner <<-'BANNER'
      Usage: pa RUBY_CODE

      The pa command show RUBY_CODE result with power_assert like format.

      [1] pry(main)> pa "0".class == "3".to_i.times.map {|i| i + 1 }.class
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
      result = ""
      code = arg_string

      proc = context[:target].eval "Proc.new {#{code}}"

      PowerAssert.start_with_string(proc, code, assertion_method: __method__) do |pa|
        pa.yield
        result = pa.message_proc.()
      end

      _pry_.pager.page result
    end

  Pry::Commands.add_command(PowerAssertCommand)
  end
end

