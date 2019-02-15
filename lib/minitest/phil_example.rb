require "minitest/phil_example/version"

# The Minitest::Assertions module is where most of the work is being done for
# matchers and other tests being performed. Here we'll put our methods that are
# then called in our test files. 
#
# Test logic doesn't need to be stored in this file completely, and can be stored 
# inside of the RubyGem's lib/ directory and then required. 
#
# Most of these tests all run the assert function and do a comparison. The reason
# we're adding our own "wrappers" is so that its easier to read, and flows more
# like plain English in our tests for people to understand what the tests are 
# doing later. Or when you've forgot what you were actually doing.
#
# This RubyGem should be required after the minitest/autorun require statement
# in files that want to run this code.
#
#    require 'minitest/autorun'
#    require 'minitest/phil_example'
#
module Minitest::Assertions
  # Minitest::Assertions#assert_equals_rounded
  #
  # This function tests if the decimal given is rounded as expected.
  #
  # @param rounded [Integer] 
  #   Number to test against.
  # @param decimal [Float] 
  #   The number being tested.
  #
  # @return [Boolean]
  def assert_equals_rounded(rounded, decimal)
    assert rounded == decimal.round, "Expected #{decimal} to round to #{rounded}"
  end

  # Minitest::Assertions#assert_palindrome
  #
  # This function tests if a given string is a Palindrome. This means a string
  # that is the same forwards as it is backwards. 
  #
  # @param string [String] 
  #   The string to test if its a palindrome.
  # 
  # @return [Boolean]
  def assert_palindrome(string)
    assert string == string.reverse, "Expected #{string} to read the same way backwards and forwards"
  end

  # Minitest::Assertions#assert_default
  #
  # @param hash [Hash] 
  #   A defined hash.
  # @param default_value [Hash] 
  #   What the hash should equal
  #
  # @return [Boolean]
  def assert_default(hash, default_value)
    assert default_value == hash.default, "Expected #{default_value} to be default value for hash but was #{hash.default.inspect}"
  end
end

# This module allows us to use our Assertions that are generally used in Unit
# Testing to be used as Expectations in Spec testing. Both are functionally the
# same, just read differently. I hold the same view that the makers of MiniTest
# do. Either, and both work. 
#
# Generally, "infecting" the module just allows the Expectations to use the 
# Assertion by the aliased name provided.
#
# infect_an_assertion ASSERTION_NAME, EXPECTATION_NAME
#
# There are more options, but those are the two that would be used the most also
# depending on how the tests are to be read.
module Minitest::Expectations
  # This Numeric.infect_an_assertion doesn't need to be in the Module block, but
  # could be called on its own. I put it in here for organization mostly. These
  # work because of how MiniTest is written, and that they infect_an_assertion
  # is just monkey-patched into the module class. So then everything that's a child
  # of module, has these functions available to it.
  #
  # However, we've "pinned" these infections to specific classes, such as 
  # Numeric, String, or Hash. So only those types have those methods available to
  # them during testing. Otherwise, anything could run these methods.

  # The Numeric class is now the only thing that can run :must_round_to
  Numeric.infect_an_assertion :assert_equals_rounded, :must_round_to
  # This infection is only available to strings.
  String.infect_an_assertion :assert_palindrome, :must_be_palindrome, :only_one_argument
  # This infection is only available to Hashes.
  Hash.infect_an_assertion :assert_default, :must_default_to, :do_not_flip
end