class Attendance < ApplicationRecord
  belongs_to :student
  belongs_to :professional
  belongs_to :school
end
