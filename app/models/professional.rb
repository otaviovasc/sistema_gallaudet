class Professional < ApplicationRecord
  has_many :attendances, dependent: :destroy

  validates :name, :profession, presence: true

  # If professionals need to be linked to multiple schools, you might create a join table (not shown here)
end
