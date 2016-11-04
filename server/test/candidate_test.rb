require 'minitest/autorun'
require 'minitest/pride'
require_relative '../dependencies'

class CandidateTest < Minitest::Test

  def setup
    Candidate.delete_all
  end

  def test_class_exists
    assert Candidate
  end
end
