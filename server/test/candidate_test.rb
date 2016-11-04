require 'minitest/autorun'
require 'minitest/pride'

require_relative 'test_helper'
require_relative '../dependencies'

class CandidateTest < Minitest::Test

  def setup
    Candidate.delete_all
    Campaign.delete_all
  end

  def test_class_exists
    assert Candidate
  end

  def test_can_create_candidate
    kvothe = Candidate.new(name: "Kvothe", image_url: "google.com", intelligence: 10, charisma: 0, willpower: 0)
    assert kvothe.save
    assert_equal "Kvothe", Candidate.last.name

  end

  def test_candidate_name_required
    kvothe = Candidate.new(name: "Kvothe", intelligence: 10, charisma: 0, willpower: 0)
    refute kvothe.save
  end

  def test_candidate_belongs_to_many_campaigns
    camp1 = Campaign.new(start_date: Date.today)
    camp2 = Campaign.new(start_date: Date.today)
    kvothe = Candidate.new(name: "Kvothe", image_url: "google.com")
    kvothe.campaigns << camp1
    kvothe.campaigns << camp2
    assert_equal [camp1, camp2], kvothe.campaigns
  end

  def test_candidate_attribute_must_be_0_to_10
    candidate = Candidate.new(name:"Kvothe",intelligence: 11, charisma: 0, willpower: 0)
    refute candidate.save
  end


end
