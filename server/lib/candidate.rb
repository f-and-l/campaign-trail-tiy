
class Candidate < ActiveRecord::Base
  include ActiveModel::Validations
  has_and_belongs_to_many :campaigns
  has_many :winners, class_name: "Campaign", foreign_key: :winner_id
  validates :name, :image_url, presence: true
  validates_with ::PointsValidator

  def total_available_points
    total_campaigns_won + 10
  end

  def total_delegated_points
    willpower + charisma + intelligence
  end

  def total_campaigns_won
    self.winners.size
  end

  def total_campaigns_competed
    self.campaigns.size
  end

end
