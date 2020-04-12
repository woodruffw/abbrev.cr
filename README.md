abbrev.cr
=========

[![Build Status](https://img.shields.io/github/workflow/status/woodruffw/abbrev.cr/CI/master)](https://github.com/woodruffw/abbrev.cr/actions?query=workflow%3ACI)

A straightforward port of Ruby's
[Abbrev](https://ruby-doc.org/stdlib/libdoc/abbrev/rdoc/Abbrev.html) to Crystal.

## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  abbrev:
    github: woodruffw/abbrev.cr
```

## Usage

Usage is nearly identical to Ruby's `Abbrev.abbrev` and `Array#abbrev`, except that the (optional)
`pattern` parameter *has* to be a regular expression:

```crystal
require "abbrev"

Abbrev.abbrev(%w{crystal})
# => {"crystal" => "crystal", "crysta" => "crystal", "cryst" => "crystal", "crys" => "crystal", "cry" => "crystal", "cr" => "crystal", "c" => "crystal"}

Abbrev.abbrev(%w{crystal ruby}, /^r/)
# => {"ruby" => "ruby", "rub" => "ruby", "ru" => "ruby", "r" => "ruby"}

%w{crystal is fun}.abbrev
# => {"crystal" => "crystal", "crysta" => "crystal", "cryst" => "crystal", "crys" => "crystal", "cry" => "crystal", "cr" => "crystal", "c" => "crystal", "is" => "is", "i" => "is", "fun" => "fun", "fu" => "fun", "f" => "fun"}
```

## Contributing

1. Fork it (https://github.com/woodruffw/abbrev/fork)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [woodruffw](https://github.com/woodruffw) William Woodruff - creator, maintainer
