require_relative "test_helper"
require_relative "../dependencies"

class AppTest < Minitest::Test
  include Rack::Test::Methods

  def app
    App
  end

  def setup
    ::Candidate.delete_all
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
end
