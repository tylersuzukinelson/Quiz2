class CreateIdeas < ActiveRecord::Migration[5.1]
  def change
    create_table :ideas do |t|
      t.string :title
      t.string :description
      t.integer :user_id
      t.integer :member_count
      t.integer :like_count

      t.timestamps
    end
  end
end
