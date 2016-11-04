
class Candidate < ActiveRecord::Base
  has_and_belongs_to_many :campaigns
  validates :name, :image_url, presence: true

end
