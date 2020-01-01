# Great Guardian

[![Build Status](https://api.travis-ci.org/cyril/great_guardian.rb.svg?branch=master)][travis]
[![Gem Version](https://badge.fury.io/rb/great_guardian.svg)][gem]
[![Inline docs](https://inch-ci.org/github/cyril/great_guardian.rb.svg?branch=master)][inchpages]
[![Documentation](http://img.shields.io/:yard-docs-38c800.svg)][rubydoc]

> Web parameters validation for Ruby 🛡️

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'great_guardian'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install great_guardian

## Usage

```ruby
class EmailAttribute < GreatGuardian::Attribute::Base
  def self.expected_value_type
    ExpectedValue::String
  end

  def self.default_constraints
    {
      pattern: /\A[^@]+@[^@]+$\z/i
    }
  end
end

email_attribute = EmailAttribute.new(required: true)
email_attribute.call()                # => "Nooo"
email_attribute.call(4)               # => "Nooo"
email_attribute.call('boom')          # => "Nooo"
email_attribute.call('bob@gmail.com') # => nil
```

## Contact

* Home page: https://github.com/cyril/great_guardian.rb
* Bugs/issues: https://github.com/cyril/great_guardian.rb/issues

## Rubies

* [MRI](https://www.ruby-lang.org/)
* [Rubinius](https://rubinius.com/)
* [JRuby](https://www.jruby.org/)

## Versioning

__GreatGuardian__ follows [Semantic Versioning 2.0](https://semver.org/).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

[gem]: https://rubygems.org/gems/great_guardian
[travis]: https://travis-ci.org/cyril/great_guardian.rb
[inchpages]: https://inch-ci.org/github/cyril/great_guardian.rb
[rubydoc]: https://rubydoc.info/gems/great_guardian/frames
