require 'minitest/autorun'
require 'minitest/pride'
require_relative '../dependencies'

class CampaignTest < Minitest::Test
  def setup
    Campaign.delete_all
    Candidate.delete_all
  end

  def test_class_exists
    assert Campaign
  end

  def test_can_create_candidate
    now = Date.today
    Campaign.create!(start_date: now)
    assert_equal now, Campaign.last.start_date
  end

  def test_can_update_candidate
    now = Date.today
    new_date = Date.new(2015, 1, 1)
    first_campaign = Campaign.create!(start_date: now)
    first_campaign.update(start_date: new_date)
    first_campaign.save
    assert_equal new_date, Campaign.find(first_campaign.id).start_date
  end
end
