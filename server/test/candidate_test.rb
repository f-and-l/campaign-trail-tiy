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

  def test_can_create_candidate
    kvothe = Candidate.new(name: "Kvothe", image_url: "google.com", intelligence: 10)
    assert kvothe.save
  end
end
