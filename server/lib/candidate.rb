
class Candidate < ActiveRecord::Base
  has_and_belongs_to_many :campaigns
  has_many :winners, class_name: "Campaign"
  validates :name, :image_url, presence: true
  validates :willpower, :charisma, :intelligence, numericality: { only_integer: true, less_than: 11 }

end
