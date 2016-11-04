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
    Candidate.create!(name: "Kvothe", image_url: "google.com", intelligence: 5)
    assert_equal "Kvothe", Candidate.last.name
  end

  def test_can_update_candidate
    kvothe = Candidate.create!(name: "Kvothe", image_url: "google.com", intelligence: 5)
    kvothe.update(name: "Kvothe Kingkiller")
    kvothe.save
    assert_equal "Kvothe Kingkiller", Candidate.find(kvothe.id).name
  end
end
