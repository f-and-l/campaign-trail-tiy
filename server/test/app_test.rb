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
    Candidate.create!(name: "Kvothe", image_url: "google.com", intelligence: 10, charisma: 0, willpower: 0)
    Candidate.create!(name: "Sim", image_url: "google.com", intelligence: 8, charisma: 0, willpower: 0)
    Candidate.create!(name: "Wil", image_url: "google.com", intelligence: 8, charisma: 0, willpower: 0)
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
      intelligence: 10,
      charisma: 0,
      willpower: 0
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

  def test_can_create_campaign_with_relevant_candidates
    devi = Candidate.create!(name: "Devi", image_url: "google.com", intelligence: 10, charisma: 0, willpower: 0)
    fela = Candidate.create!(name: "Fela", image_url: "google.com", intelligence: 10, charisma: 0, willpower: 0)
    payload = {
      start_date: Date.today,
      candidates: [devi.id, fela.id]
    }
    post "/campaigns", payload.to_json
    assert_equal 201, last_response.status
    assert_equal Date.today, ::Campaign.last.start_date
    assert_equal [devi, fela], ::Campaign.last.candidates
  end

  def test_creating_campaign_with_unknown_candidates_returns_404
    Candidate.create!(name: "Devi", image_url: "google.com", intelligence: 10, charisma: 0, willpower: 0)
    Candidate.create!(name: "Fela", image_url: "google.com", intelligence: 10, charisma: 0, willpower: 0)
    payload = {
      start_date: Date.today,
      candidates: [Candidate.last.id + 1, Candidate.last.id + 2]
    }
    post "/campaigns", payload.to_json
    assert_equal 404, last_response.status
    assert_equal "Candidate(s) [#{Candidate.last.id + 1}, #{Candidate.last.id + 2}] not found!", JSON.parse(last_response.body)["message"]
  end

  def test_can_get_one_candidate
    Candidate.create!(name: "Kvothe", image_url: "google.com", intelligence: 10, charisma: 0, willpower: 0)
    get "/candidates/#{Candidate.last.id}"
    assert_equal "Kvothe", JSON.parse(last_response.body)["name"]
  end

  def test_404_for_candidate_not_found
    get "/candidates/#{Candidate.last.id + 1}"
    assert_equal 404, last_response.status
    assert_equal "Candidate #{Candidate.last.id + 1} not found!", JSON.parse(last_response.body)["message"]
  end

  def test_get_one_campaign
    Campaign.create!(start_date: Date.today)
    get "/campaigns/#{Campaign.last.id}"
    assert_equal "2016-11-04T00:00:00.000Z", JSON.parse(last_response.body)["start_date"]
  end

  def test_404_for_campaign_not_found
    Campaign.create!(start_date: Date.today)
    get "/campaigns/#{Campaign.last.id + 1}"
    assert_equal 404, last_response.status
    assert_equal "Campaign #{Campaign.last.id + 1} not found!", JSON.parse(last_response.body)["message"]
  end

  def test_can_get_all_campaigns_belonging_to_candidate
    camp1 = Campaign.create!(start_date: Date.yesterday)
    camp2 = Campaign.create!(start_date: Date.today)
    devi = Candidate.create!(name: "Devi", image_url: "google.com", campaigns: [camp1, camp2], intelligence: 10, charisma: 0, willpower: 0)
    get "/candidates/#{devi.id}/campaigns"
    assert last_response.ok?
    assert_equal 2, JSON.parse(last_response.body).size
    assert_equal camp1.id, JSON.parse(last_response.body)[0]["id"]
    assert_equal camp2.id, JSON.parse(last_response.body)[1]["id"]
  end

  def test_can_delete_candidate
    devi = Candidate.create!(name: "Devi", image_url: "google.com", intelligence: 10, charisma: 0, willpower: 0)
    delete "/candidates/#{devi.id}"
    assert last_response.ok?
    assert_raises do
      Candidate.find(devi.id)
    end
  end

  def test_can_update_candidate
    devi = Candidate.create!(name: "Devi", image_url: "google.com", intelligence: 10, charisma: 0, willpower: 0)
    payload = {
      intelligence: 8
    }
    patch "/candidates/#{devi.id}", payload.to_json
    assert_equal 8, Candidate.find(devi.id).intelligence
  end

end
