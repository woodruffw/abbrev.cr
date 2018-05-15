require "./spec_helper"

describe Abbrev do
  it "does nothing with an empty list" do
    Abbrev.abbrev([] of String).should eq({} of String => String)
  end

  it "generates abbreviations" do
    expected1 = {
      "summer" => "summer",
      "summe"  => "summer",
      "summ"   => "summer",
      "sum"    => "summer",
      "su"     => "summer",
      "s"      => "summer",
      "winter" => "winter",
      "winte"  => "winter",
      "wint"   => "winter",
      "win"    => "winter",
      "wi"     => "winter",
      "w"      => "winter",
    }

    Abbrev.abbrev(%w{summer winter}).should eq(expected1)

    expected2 = {
      "ruby"  => "ruby",
      "rub"   => "ruby",
      "rules" => "rules",
      "rule"  => "rules",
      "rul"   => "rules",
    }

    Abbrev.abbrev(%w{ruby rules}).should eq(expected2)
  end

  it "filters abbreviations based on a pattern" do
    expected = {
      "summer" => "summer",
      "summe"  => "summer",
      "summ"   => "summer",
      "sum"    => "summer",
    }

    Abbrev.abbrev(%w{summer winter}, /^sum/).should eq(expected)
  end
end

describe Array do
  describe "#abbrev" do
    it "behaves like Abbrev.abbrev" do
      expected = {
        "summer" => "summer",
        "summe"  => "summer",
        "summ"   => "summer",
        "sum"    => "summer",
      }

      %w{summer winter}.abbrev(/^sum/).should eq(expected)
    end
  end
end
