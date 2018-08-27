class AddMonthToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :month, :integer
  end
end
