class AddCountToAdmins < ActiveRecord::Migration[5.2]
  def change
    add_column :admins, :count, :integer
  end
end
