class Enrollment < ApplicationRecord
  belongs_to :student
  belongs_to :course
  belongs_to :creator, class_name: 'User', foreign_key: 'created_by'

  # Optionally, validate enrollment_date presence
  validates :enrollment_date, presence: true
end
