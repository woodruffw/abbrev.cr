require "./abbrev/*"

# Calculates the set of unambiguous abbreviations for a given set of strings.
#
# This module is a straightforward port of Ruby's
# [`Abbrev`](https://ruby-doc.org/stdlib/libdoc/abbrev/rdoc/Abbrev.html).
module Abbrev
  extend self

  # Generates a table of unambiguous abbreviations for each word in *words*.
  #
  # If *pattern* is given, then only those abbreviations that match the pattern
  # are included in the table.
  #
  # Returns a `Hash` containing the mappings of abbreviations to words.
  #
  # ```
  # Abbrev.abbrev(%w{crystal})
  # # => {"crystal" => "crystal", "crysta" => "crystal", "cryst" => "crystal", "crys" => "crystal", "cry" => "crystal", "cr" => "crystal", "c" => "crystal"}
  #
  # Abbrev.abbrev(%w{crystal ruby}, /^r/)
  # # => {"ruby" => "ruby", "rub" => "ruby", "ru" => "ruby", "r" => "ruby"}
  # ```
  def abbrev(words : Enumerable(String), pattern : Regex? = nil)
    table = {} of String => String
    seen = Hash(String, Int64).new(0_i64)

    words.each do |word|
      next if word.empty?

      word.size.downto(1) do |len|
        abbrev = word[0...len]

        next if pattern && pattern !~ abbrev

        case seen[abbrev] += 1
        when 1
          table[abbrev] = word
        when 2
          table.delete(abbrev)
        else break
        end
      end
    end

    words.each do |word|
      next if pattern && pattern !~ word
      table[word] = word
    end

    table
  end
end

class Array(T)
  # See `Abbrev.abbrev`.
  #
  # ```
  # %w{crystal is fun}.abbrev
  # # => {"crystal" => "crystal", "crysta" => "crystal", "cryst" => "crystal", "crys" => "crystal", "cry" => "crystal", "cr" => "crystal", "c" => "crystal", "is" => "is", "i" => "is", "fun" => "fun", "fu" => "fun", "f" => "fun"}
  # ```
  def abbrev(pattern : Regex? = nil)
    Abbrev.abbrev(self, pattern)
  end
end
