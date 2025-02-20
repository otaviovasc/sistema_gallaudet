class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :school, optional: true   # Optional for general managers who may not be tied to a specific school

  # Associations for audit trails:
  has_many :enrollments, foreign_key: 'created_by', dependent: :nullify
  has_many :attendances, foreign_key: 'created_by', dependent: :nullify

  # # Validate role presence and inclusion
  validates :role, inclusion: { in: %w[manager_unit manager_general] }

  # For unit managers, the school must be present
  validates :school, presence: true, if: -> { role == "manager_unit" }
end
