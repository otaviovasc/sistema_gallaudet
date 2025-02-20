class AddRoleAndSchoolIdToUsers < ActiveRecord::Migration[8.0]
  def change
        # Adds a role column with a default value of 'manager_general'
        add_column :users, :role, :string, null: false, default: "manager_general"
        # Adds a school reference (foreign key). This can be null for general managers.
        add_reference :users, :school, foreign_key: true, null: true
  end
end
