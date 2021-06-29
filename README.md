# Great Guardian

[![Version](https://img.shields.io/github/v/tag/cyril/great_guardian.rb?label=Version&logo=github)](https://github.com/cyril/great_guardian.rb/releases)
[![Yard documentation](https://img.shields.io/badge/Yard-documentation-blue.svg?logo=github)](https://rubydoc.info/github/cyril/great_guardian.rb/main)
[![CI](https://github.com/cyril/great_guardian.rb/workflows/CI/badge.svg?branch=main)](https://github.com/cyril/great_guardian.rb/actions?query=workflow%3Aci+branch%3Amain)
[![RuboCop](https://github.com/cyril/great_guardian.rb/workflows/RuboCop/badge.svg?branch=main)](https://github.com/cyril/great_guardian.rb/actions?query=workflow%3Arubocop+branch%3Amain)
[![License](https://img.shields.io/github/license/cyril/great_guardian.rb?label=License&logo=github)](https://github.com/cyril/great_guardian.rb/raw/main/LICENSE.md)

> Web parameters validation for Ruby 🛡️

## Installation

Add this line to your application's Gemfile:

```ruby
gem "great_guardian", ">= 0.1.0.beta1"
```

And then execute:

```sh
bundle install
```

Or install it yourself as:

```sh
gem install great_guardian --pre
```

## Usage

```ruby
class EmailAttribute < GreatGuardian::Attribute::Base
  def self.default_constraints
    {
      pattern: /\A[^@]+@[^@]+$\z/i
    }
  end

  def self.expected_value_type
    ::GreatGuardian::ExpectedValue::String
  end
end

email_attribute = EmailAttribute.new(required: true)

email_attribute.call(nil) # => #<GreatGuardian::Verdict:0x00007ffd3f00ad40 @attribute_name="email_attribute", @value=nil, @error_message=["attribute.email_attribute.errors.required", {:name=>["attribute.email_attribute.name"], :expected=>nil}], @medium=:body>
email_attribute.call(4) # => #<GreatGuardian::Verdict:0x00007ffd3e360590 @attribute_name="email_attribute", @value=4, @error_message=["attribute.email_attribute.errors.type", {:name=>["attribute.email_attribute.name"], :expected=>["expected_value.string.type"]}], @medium=:body>
email_attribute.call("boom") # => #<GreatGuardian::Verdict:0x00007ffd3e3d8360 @attribute_name="email_attribute", @value="boom", @error_message=["attribute.email_attribute.errors.pattern", {:name=>["attribute.email_attribute.name"], :expected=>/\A[^@]+@[^@]+$\z/i}], @medium=:body>
email_attribute.call("bob@gmail.com") # => #<GreatGuardian::Verdict:0x00007ffd3e3c23d0 @attribute_name="email_attribute", @value="bob@gmail.com", @error_message=nil, @medium=:body>
```

### Rails integration example

```ruby
# app/controllers/signup_controller.rb
class SignupController < ApplicationController
  def create
    email = EmailAttribute.new(required: true).call(params["email"])

    if email.valid?
      User.create!(email: email.value)
    else
      render json: { email: I18n.t(*email.error_message) }, status: :unprocessable_entity
    end
  end
end
```

## Built-in expected values

* `GreatGuardian::ExpectedValue::Array` (constraints: `minlen`, `maxlen`)
* `GreatGuardian::ExpectedValue::Boolean`
* `GreatGuardian::ExpectedValue::Number` (constraints: `min`, `max`)
* `GreatGuardian::ExpectedValue::String` (constraints: `minlen`, `maxlen`, `pattern`)

## Contact

* Source code: https://github.com/cyril/great_guardian.rb

## Versioning

__GreatGuardian__ follows [Semantic Versioning 2.0](https://semver.org/).

## License

The [gem](https://rubygems.org/gems/great_guardian) is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
