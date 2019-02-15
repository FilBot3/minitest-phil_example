#!/usr/bin/env ruby
# encoding: UTF-8

require 'minitest/phil_example'
require 'minitest/autorun'

describe 'custom expectations' do 
  describe '#must_round_to' do 
    it 'rounds correctly Float' do
      1.2.must_round_to 1
    end

    it 'rounds correctly for Fixnum' do
      1.must_round_to 1
    end

    it 'catches failures' do
      proc { 1.5.must_round_to 42 }.must_raise(MiniTest::Assertion)
    end
  end

  describe '#must_be_palindrome' do
    it 'reads a string backwards and forwards' do
      'racecar'.must_be_palindrome
    end

    it 'catches failures' do
      proc { 'kriss kross'.must_be_palindrome }.must_raise(MiniTest::Assertion)
    end

    it 'only works for Strings' do
      proc { 1.must_be_palindrome }.must_raise(NoMethodError)
    end
  end

  describe '#must_default_to' do
    it 'compares the default value of a hash' do
      hash = Hash.new(42)
      hash.must_default_to 42
    end

    it 'catches failures' do
      proc { {}.must_default_to 42 }.must_raise(MiniTest::Assertion)
    end

    it 'only works for Hashes' do
      proc { 1.must_default_to 2 }.must_raise(NoMethodError)
    end
  end
end