

require 'bundler/setup'
require 'sinatra'
require 'json'

require_relative 'database'
require_relative '../dependencies'

class App < Sinatra::Base
  # Serve any HTML/CSS/JS from the client folder
  set :static, true
  set :public_folder, proc { File.join(root, '..', '..', 'client', 'public') }

  # Enable the session store
  enable :sessions

  # This ensures that we always return the content-type application/json
  before do
    content_type 'application/json'
  end

  # DO NOT REMOVE THIS ENDPOINT IT ENABLES HOSTING HTML FOR THE FRONT END
  get '/' do
    content_type 'text/html'
    body File.read(File.join(settings.public_folder, 'index.html'))
  end

  get '/candidates' do
    ::Candidate.all.to_json
  end

  get '/candidates/:id' do
    candidate = ::Candidate.find_by(id: params["id"])
    if candidate
      candidate.to_json
    else
      status 404
      {message: "Candidate #{params["id"]} not found!"}.to_json
    end
  end

  get '/campaigns' do
    ::Campaign.all.to_json
  end

  get "/candidates/:id/campaigns" do
    candidate = ::Candidate.find_by(id: params["id"])
    if candidate
      candidate.campaigns.to_json
    else
      status 404
      {message: "Candidate #{params["id"]} not found!"}.to_json
    end
  end

  get '/campaigns/:id' do
    campaign = ::Campaign.find_by(id: params["id"])
    if campaign
      campaign.to_json
    else
      status 404
      {message: "Campaign #{params["id"]} not found!"}.to_json
    end
  end

  post '/candidates' do
    input = request.body.read
    input_hash = JSON.parse(input)
    candidate = ::Candidate.new(input_hash)
    if candidate.save
      status 201
      candidate.to_json
    else
      status 422
      {
        errors: {
          full_messages: candidate.errors.full_messages,
          messages: candidate.errors.messages
        }
      }.to_json
    end
  end

  post '/campaigns' do
    input = request.body.read
    input_hash = JSON.parse(input)
    candidates_array = []
    candidates_id_array = []
    input_hash["candidates"].each do |id|
      candidates_array << Candidate.find_by(id: id) if Candidate.find_by(id: id)
      candidates_id_array << Candidate.find_by(id: id).id if Candidate.find_by(id: id)
    end
    campaign = ::Campaign.new(start_date: input_hash["start_date"], candidates: candidates_array)
    if campaign.save && candidates_array.size == input_hash["candidates"].size
      status 201
      campaign.to_json
    elsif candidates_array.size != input_hash["candidates"].size
      status 404
      not_found = input_hash["candidates"] - candidates_id_array
      {message: "Candidate(s) #{not_found} not found!"}.to_json
    else
      status 422
      {
        errors: {
          full_messages: campaign.errors.full_messages,
          messages: campaign.errors.messages
        }
      }.to_json
    end
  end

  delete '/candidates/:id' do
    ::Candidate.find_by(id: params["id"]).destroy
    
  end

  # If this file is run directly boot the webserver
  run! if app_file == $PROGRAM_NAME
end
