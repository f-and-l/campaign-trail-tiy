

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
    input_params = input_hash.select{ |k,v| (input_hash.keys & Candidate.attribute_names).find_index(k) }
    candidate = ::Candidate.new(input_params)
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
    candidates = []
    candidates_ids = []
    input_hash["candidates"].each do |id|
      candidates << Candidate.find_by(id: id) && candidates_ids << id if Candidate.find_by(id: id)
    end
    campaign = ::Campaign.new(start_date: input_hash["start_date"] || Date.today, candidates: candidates)
    if campaign.save && candidates.size == input_hash["candidates"].size
      campaign.assign_winner!
      status 201
      campaign.to_json
    elsif candidates.size != input_hash["candidates"].size
      status 404
      not_found = input_hash["candidates"] - candidates_ids
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

  patch '/candidates/:id' do
    input = request.body.read
    input_hash = JSON.parse(input)
    candidate = Candidate.find(params["id"])
    candidate.update!(input_hash)
    candidate.to_json
  end

  # If this file is run directly boot the webserver
  run! if app_file == $PROGRAM_NAME
end
