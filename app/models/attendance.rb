class Attendance < ApplicationRecord
  belongs_to :student
  belongs_to :professional
  belongs_to :school
  belongs_to :creator, class_name: 'User', foreign_key: 'created_by'

  validates :date, :start_time, :end_time, presence: true

  # Add more validations or methods as needed (e.g., status updates)
end
