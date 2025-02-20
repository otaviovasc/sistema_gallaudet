class School < ApplicationRecord
  has_many :users
  has_many :courses
  has_many :attendances

  # Optionally, add validations:
  validates :name, presence: true
end
