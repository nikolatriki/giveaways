class RemoveColumnClaimedAddColumnApprovedTo < ActiveRecord::Migration[6.1]
  def change
    remove_column :giveaways, :claimed, :boolean, default: false
    add_column :giveaways, :approved_to, :bigint
  end
end
