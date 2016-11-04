require_relative "test_helper"
require_relative "../dependencies"

class AppTest < Minitest::Test
  include Rack::Test::Methods

  def app
    App
  end

  def setup
    ::Candidate.delete_all
    ::Campaign.delete_all
    Candidate.create!(name: "Kvothe", image_url: "google.com", intelligence: 10)
    Candidate.create!(name: "Sim", image_url: "google.com", intelligence: 8)
    Candidate.create!(name: "Wil", image_url: "google.com", intelligence: 8)
  end

  def test_can_get_all_candidates
    response = get "/candidates"
    assert response.ok?
    hash_response = JSON.parse(response.body)
    assert_equal "Kvothe", hash_response[0]["name"]
    assert_equal 3, hash_response.size
  end

  def test_can_create_candidate
    payload = {
      name: "Fela",
      image_url: "google.com",
      intelligence: 10
    }
    post "/candidates", payload.to_json
    assert_equal 201, last_response.status
    assert_equal "Fela", ::Candidate.last.name
  end

  def test_can_get_all_campaigns
    today = Date.today
    Campaign.create!(start_date: today)
    response = get "/campaigns"
    assert response.ok?
    hash_response = JSON.parse(response.body)
    assert_equal "2016-11-04T00:00:00.000Z", hash_response[0]["start_date"]
  end
end
