class AddUniqConstraintsInClaimsTable < ActiveRecord::Migration[6.1]
  def change
    add_index :claims, [:user_id, :giveaway_id], unique: true
  end
end
