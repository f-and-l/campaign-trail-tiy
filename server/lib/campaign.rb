
class Campaign < ActiveRecord::Base
  has_and_belongs_to_many :candidates
  belongs_to :winner, class_name: "Candidate", foreign_key: :winner_id
  validates :start_date, presence: true

end
