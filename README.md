Hexx::CLI
=========

[![Gem Version](https://img.shields.io/gem/v/hexx-cli.svg?style=flat)][gem]
[![Build Status](https://img.shields.io/travis/nepalez/hexx-cli/master.svg?style=flat)][travis]
[![Dependency Status](https://img.shields.io/gemnasium/nepalez/hexx-cli.svg?style=flat)][gemnasium]
[![Code Climate](https://img.shields.io/codeclimate/github/nepalez/hexx-cli.svg?style=flat)][codeclimate]
[![Coverage](https://img.shields.io/coveralls/nepalez/hexx-cli.svg?style=flat)][coveralls]

[codeclimate]: https://codeclimate.com/github/nepalez/hexx-cli
[coveralls]: https://coveralls.io/r/nepalez/hexx-cli
[gem]: https://rubygems.org/gems/hexx-cli
[gemnasium]: https://gemnasium.com/nepalez/hexx-cli
[travis]: https://travis-ci.org/nepalez/hexx-cli

The module contains:

* `Hexx::CLI::Base` - the [Thor::Group]-based generator, extended by additional helper methods
* `Hexx::CLI::Name` - the parser for the generator argument or option.

[Thor::Group]: https://github.com/erikhuda/thor

Installation
------------

Add this line to your application's Gemfile:

```ruby
# Gemfile
group :development do
  gem "hexx-cli", require: false
end
```

Then execute:

```
bundle
```

Or add it manually:

```
gem install hexx-cli
```

Usage
-----

## Hexx::CLI::Base

Create custom generator class, inherited from the `Hexx::CLI::Base`:

```ruby
class CLI < Hexx::CLI::Base
end
```

The generator includes `Thor::Actions` as well as private helper methods:

* source_path
* copy_folder
* from_template

### #source_path

The method returns the source path setting for the class.

### #copy_folder

The method recursively copies files from the source folder to the desinaton.

```ruby
copy_folder "source", "target", skip: true
```

Its behaviour differs from the Thor::Actions `directory` in two aspects:

* The leading underscore is authomatically removed from the filename. This makes it possible to copy dotfiles:

```
source/_.coveralls.yml --> target/.coveralls.yml
```

* If the source file has `.erb` extension, it is treated as the template. Such files are preprocessed by the ruby `ERB` parser and copied to the destination without `.erb` extension:

```
source/spec_helper.rb.erb --> target/spec_helper.rb
```

### #from_template

The method returns the content of `ERB`-preprocessed template.

```ruby
from_template "template.erb"
```

It can be used to append, prepend or inject the content from template to existing files:

```ruby
append_to_file "filename", from_template("template.erb")
```

## Hexx::CLI::Name

The parser takes the string and decorates it with methods for naming conventions:

```ruby
name = Hexx::CLI::Name "mammals/carnivores-cats::wildcats.purr"

name.item
# => "wildcat"
name.items
# => "wildcats"
name.file
# => "mammals-carnivores-cats-wildcats.purr"
name.path
# => "mammals/carnivores/cats/wildcats.purr"
name.type
# => "Mammals::Carnivores::Cats::Wildcats.purr"
name.const
# => "Wildcats.purr"
name.namespaces
# => %w(Mammals Carnivores Cats)
```

Compatibility
-------------

Tested under rubies, compatible with MRI 2.0+:

* MRI 2.0+
* Rubinius 2+ (2.0 mode only)
* JRuby-head (2.0 mode only)

Uses [RSpec] 3.0+ and [hexx-rspec] settings for the test environment.

[RSpec]: http://rspec.info/

License
-------

See the [MIT LICENSE](LICENSE).
