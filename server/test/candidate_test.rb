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
    kvothe = Candidate.new( intelligence: 10, charisma: 0, willpower: 0, image_url: "google.com")
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
    candidate = Candidate.new(name:"Kvothe",intelligence: 11, charisma: 0, willpower: 0, image_url: "google.com")
    refute candidate.save
  end

  def test_candidate_can_win_campaign
    camp1 = Campaign.new(start_date: Date.today)
    kvothe = Candidate.new(name:"Kvothe",intelligence: 10, charisma: 0, willpower: 0, image_url: "google.com")
    camp1.winner = kvothe
    camp1.save!
    kvothe.save!
    assert_equal kvothe.id, camp1.winner_id
    assert_equal [camp1], kvothe.winners
  end

  def test_candidate_total_campaigns_competed
    camp1 = Campaign.new(start_date: Date.today)
    camp2 = Campaign.new(start_date: Date.tomorrow)
    kvothe = Candidate.new(name:"Kvothe",intelligence: 10, charisma: 0, willpower: 0, image_url: "google.com")
    kvothe.campaigns = [camp1, camp2]
    assert_equal 2, kvothe.total_campaigns_competed
  end

  def test_candidate_total_campaigns_won
    camp1 = Campaign.new(start_date: Date.today)
    camp2 = Campaign.new(start_date: Date.tomorrow)
    kvothe = Candidate.new(name:"Kvothe",intelligence: 10, charisma: 0, willpower: 0, image_url: "google.com")
    kvothe.campaigns = [camp1, camp2]
    camp1.winner = kvothe
    camp2.winner = kvothe
    kvothe.save!
    assert_equal 2, kvothe.total_campaigns_won
  end

  def test_total_delegated_points
    kvothe = Candidate.create!(name:"Kvothe",intelligence: 5, charisma: 2, willpower: 0, image_url: "google.com")
    assert_equal 7, kvothe.total_delegated_points
  end

end
