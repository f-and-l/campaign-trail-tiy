
class Campaign < ActiveRecord::Base
  has_and_belongs_to_many :candidates
  validates :start_date, presence: true

end
