class AddClaimedToGiveaways < ActiveRecord::Migration[6.1]
  def change
    add_column :giveaways, :claimed, :boolean, default: false
  end
end
