require "minitest/phil_example/version"

module Minitest::Assertions
  def assert_equals_rounded(rounded, decimal)
    assert rounded == decimal.round, "Expected #{decimal} to round to #{rounded}"
  end

  def assert_palindrome(string)
    assert string == string.reverse, "Expected #{string} to read the same way backwards and forwards"
  end

  def assert_default(hash, default_value)
    assert default_value == hash.default, "Expected #{default_value} to be default value for hash but was #{hash.default.inspect}"
  end
end

module Minitest::Expectations
  Numeric.infect_an_assertion :assert_equals_rounded, :must_round_to
  String.infect_an_assertion :assert_palindrome, :must_be_palindrome, :only_one_argument
  Hash.infect_an_assertion :assert_default, :must_default_to, :do_not_flip
end