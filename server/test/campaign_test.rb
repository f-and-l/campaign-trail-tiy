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
    cand1 = Candidate.create!(name: "Cand1", image_url: "google.com", intelligence: 2, charisma: 4, willpower: 1)
    cand2 = Candidate.create!(name: "Cand2", image_url: "google.com", intelligence: 4, charisma: 5, willpower: 1)
    cand3 = Candidate.create!(name: "Cand3", image_url: "google.com", intelligence: 3, charisma: 3, willpower: 4)
    campaign.candidates = [cand1, cand2, cand3]
    campaign.save!
    winners = []
    50.times do
      campaign.assign_winner!
      winners << campaign.winner.name
    end
    assert_equal "Cand2", winners.max_by{ |i| winners.count(i) }
    assert winners.index("Cand1")
    assert winners.index("Cand2")
  end
end
