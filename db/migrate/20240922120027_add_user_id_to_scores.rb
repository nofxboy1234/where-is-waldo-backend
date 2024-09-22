class AddUserIdToScores < ActiveRecord::Migration[7.2]
  def change
    add_column :scores, :user_id, :string
  end
end
