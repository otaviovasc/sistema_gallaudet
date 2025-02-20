class Course < ApplicationRecord
  belongs_to :school
  has_many :enrollments, dependent: :destroy
  has_many :students, through: :enrollments

  validates :name, :start_date, :end_date, presence: true
end
