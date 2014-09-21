require 'pry/test/helper'
require 'pry-power_assert'

describe "ps command" do
  it "should show power_assert result" do
    pry_eval(%q{pa "0".class == "3".to_i.times.map {|i| i + 1 }.class}).chomp.should == <<END.chomp
result: false

"0".class == "3".to_i.times.map {|i| i + 1 }.class
    |     |      |    |     |                |
    |     |      |    |     |                Array
    |     |      |    |     [1, 2, 3]
    |     |      |    #<Enumerator: 3:times>
    |     |      3
    |     false
    String
END
  end

  it "should show power_assert result" do
    pry_eval(%q{a = 10})
    pry_eval(%q{b = 20})
    pry_eval(%q{pa a + b + 30}).chomp.should == <<END.chomp
result: 60

a + b + 30
| | | |
| | | 60
| | 20
| 30
10
END
  end

  it "should show power_assert result" do
    pry_eval(%q{@a = 10})
    pry_eval(%q{@b = 20})
    pry_eval(%q{pa @a + @b + 30}).chomp.should == <<END.chomp
result: 60

@a + @b + 30
|  | |  |
|  | |  60
|  | 20
|  30
10
END
  end
end
