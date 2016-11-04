require 'minitest/autorun'
require 'minitest/pride'

require_relative 'test_helper'
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
    assert_equal "Kvothe", Candidate.last.name
  end

  def test_candidate_name_required
    kvothe = Candidate.new(name: "Kvothe", intelligence: 10)
    refute kvothe.save
  end


end
