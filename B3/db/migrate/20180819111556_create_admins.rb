class CreateAdmins < ActiveRecord::Migration[5.2]
  def change
    create_table :admins do |t|
      t.string :admin_name
      t.string :password_digest

      t.timestamps
    end
  end
end
