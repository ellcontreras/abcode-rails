class DefaultValueToUserRole < ActiveRecord::Migration[5.2]
  def change
    change_column_default :users, :role, from: "", to: "student"
  end
end
