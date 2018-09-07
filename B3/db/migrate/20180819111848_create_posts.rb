class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.integer :admin_id
      t.integer :user_id
      t.string :title
      t.text :body
      t.string :categories
      t.boolean :post_check
      t.references :postable, polymorphic: true

      t.timestamps
    end
    add_index :posts, :admin_id
    add_index :posts, :user_id
  end
end
