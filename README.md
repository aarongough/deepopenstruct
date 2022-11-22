# DeepOpenStruct

DeepOpenStruct is a simple library for creating easy-to-use data structures from complex sets of nested Hashes and Arrays. It is particularly suitable for creating easy-to-use data structures from YAML files, and as such is a useful tool for creating simple reflective API wrappers.

## Installation

Add DeepOpenStruct to your gemfile:

```ruby
gem 'deepopenstruct', '~>0.1.3'
```

And then execute:

```
bundle install
```

Or install it manually by entering the following at your command line:

```
gem install deepopenstruct
```
  
## Usage

```ruby
require 'rubygems'
require 'deepopenstruct'

complex_data = {
  :name => "Bob Winkle",
  :age => 65,
  :jobs => [
    {'start_year' => 1980, 'title' => 'Chef'},
    {'start_year' => 1985, 'title' => 'Programmer'}
  ],
  :attributes => {
    :birthplace => "Darwin",
    :year_of_birth => 1945
  }
}

simple_data = DeepOpenStruct.load(complex_data)

simple_data.name
# => "Bob Winkle"

simple_data.jobs.first.title
# => "Chef"

simple_data.attributes.birthplace
# => "Darwin"
```

### Contributing:

Contributions are always welcome! Please create a pull request that clearly outlines the work you've done. Make sure your changes include updating or adding relevant tests, and use [Rubocop](https://github.com/rubocop/rubocop) to make sure your additions adhere to the same style as the rest of the project!

### Author & Credits:

Author: [Aaron Gough](mailto:aaron@aarongough.com)
Copyright © 2022 [Aaron Gough](http://thingsaaronmade.com/), released under the MIT license