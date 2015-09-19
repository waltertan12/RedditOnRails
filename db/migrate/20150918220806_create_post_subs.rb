class CreatePostSubs < ActiveRecord::Migration
  def change
    create_table :post_subs do |t|
      t.integer :post_id, null: false, index: true
      t.integer :sub_id, null: false, index: true
      t.timestamps null: false
    end
    add_index :post_subs, [:post_id, :sub_id], unique: true
  end
end
