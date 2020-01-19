# Great Guardian

[![Build Status](https://api.travis-ci.org/cyril/great_guardian.rb.svg?branch=master)][travis]
[![Gem Version](https://badge.fury.io/rb/great_guardian.svg)][gem]
[![Inline docs](https://inch-ci.org/github/cyril/great_guardian.rb.svg?branch=master)][inchpages]
[![Documentation](http://img.shields.io/:yard-docs-38c800.svg)][rubydoc]

> Web parameters validation for Ruby 🛡️

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'great_guardian', '>= 0.1.0.beta1'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install great_guardian --pre

## Usage

```ruby
class EmailAttribute < GreatGuardian::Attribute::Base
  def self.expected_value_type
    ::GreatGuardian::ExpectedValue::String
  end

  def self.default_constraints
    {
      pattern: /\A[^@]+@[^@]+$\z/i
    }
  end
end

email_attribute = EmailAttribute.new(required: true)

email_attribute.call(nil) # => #<GreatGuardian::Verdict:0x00007ffd3f00ad40 @attribute_name="email_attribute", @value=nil, @error_message=["attribute.email_attribute.errors.required", {:name=>["attribute.email_attribute.name"], :expected=>nil}], @medium=:body>
email_attribute.call(4) # => #<GreatGuardian::Verdict:0x00007ffd3e360590 @attribute_name="email_attribute", @value=4, @error_message=["attribute.email_attribute.errors.type", {:name=>["attribute.email_attribute.name"], :expected=>["expected_value.string.type"]}], @medium=:body>
email_attribute.call('boom') # => #<GreatGuardian::Verdict:0x00007ffd3e3d8360 @attribute_name="email_attribute", @value="boom", @error_message=["attribute.email_attribute.errors.pattern", {:name=>["attribute.email_attribute.name"], :expected=>/\A[^@]+@[^@]+$\z/i}], @medium=:body>
email_attribute.call('bob@gmail.com') # => #<GreatGuardian::Verdict:0x00007ffd3e3c23d0 @attribute_name="email_attribute", @value="bob@gmail.com", @error_message=nil, @medium=:body>
```

## Built-in expected values

### `GreatGuardian::ExpectedValue::Array`

Constraints:

* `minlen`
* `maxlen`

### `GreatGuardian::ExpectedValue::Boolean`

### `GreatGuardian::ExpectedValue::Number`

Constraints:

* `min`
* `max`

### `GreatGuardian::ExpectedValue::String`

Constraints:

* `minlen`
* `maxlen`
* `pattern`

## Contact

* Source code: https://github.com/cyril/great_guardian.rb

## Versioning

__GreatGuardian__ follows [Semantic Versioning 2.0](https://semver.org/).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

[gem]: https://rubygems.org/gems/great_guardian
[travis]: https://travis-ci.org/cyril/great_guardian.rb
[inchpages]: https://inch-ci.org/github/cyril/great_guardian.rb
[rubydoc]: https://rubydoc.info/gems/great_guardian/frames
