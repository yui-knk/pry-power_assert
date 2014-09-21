# PryPowerAssert

Provides power assert support for Pry

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'pry-power_assert'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install pry-power_assert

## Usage

Start Pry.

```shell
$ pry
```

Type `pa RUBY_CODE`

```ruby
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
```

## Contributing

1. Fork it ( https://github.com/yui-knk/pry-power_assert/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
