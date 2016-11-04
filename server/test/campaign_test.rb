require 'minitest/autorun'
require 'minitest/pride'

require_relative 'test_helper'
require_relative '../dependencies'

class CampaignTest < Minitest::Test

  def setup
    Campaign.delete_all
    Candidate.delete_all
  end

  def test_class_exists
    assert Campaign
  end

  def test_can_create_campaign
    today = Date.today
    Campaign.create!(start_date: today)
    assert_equal today, Campaign.last.start_date
  end

  def test_campaign_must_have_start_date
    campaign = Campaign.new()
    refute campaign.save
  end

  def test_campaign_has_winner
    winner = Candidate.new(name: "Kvothe", image_url: "google.com")
    campaign = Campaign.new(start_date: Date.today, winner: winner)
    assert_equal winner, campaign.winner
  end

  def test_campaign_has_many_candidates
    campaign = Campaign.new(start_date: Date.today)
    kvothe = Candidate.new(name: "Kvothe", image_url: "google.com")
    fela = Candidate.new(name: "Fela", image_url: "google.com")
    campaign.candidates << kvothe
    campaign.candidates << fela
    assert_equal [kvothe, fela], campaign.candidates
  end

  def test_campaign_set_winner
    campaign = Campaign.create!(start_date: Date.today)
    cand1 = Candidate.create!(name: "Cand1", image_url: "google.com", intelligence: 5, charisma: 5, willpower: 2)
    cand2 = Candidate.create!(name: "Cand2", image_url: "google.com", intelligence: 4, charisma: 5, willpower: 5)
    cand3 = Candidate.create!(name: "Cand2", image_url: "google.com", intelligence: 2, charisma: 6, willpower: 8)
    campaign.candidates = [cand1, cand2, cand3]
    campaign.save!
    campaign.assign_winner!
    assert_equal cand3, campaign.winner
  end
end
