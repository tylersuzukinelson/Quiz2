class AddFlagColumnToReviews < ActiveRecord::Migration[5.1]
  def change
    add_column :reviews, :flag, :boolean, default: false
  end
end
