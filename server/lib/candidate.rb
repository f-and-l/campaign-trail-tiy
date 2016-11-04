
class Candidate < ActiveRecord::Base
  has_and_belongs_to_many :campaigns
  has_many :winners, class_name: "Campaign", foreign_key: :winner_id
  validates :name, :image_url, presence: true
  validates :willpower, :charisma, :intelligence, numericality: { only_integer: true, less_than: 11 }

  def total_available_points
    number_campaigns_won + 10
  end

  def total_delegated_points
    willpower + charisma + intelligence
  end

  def total_campaigns_won
    self.winners.size
  end

end
