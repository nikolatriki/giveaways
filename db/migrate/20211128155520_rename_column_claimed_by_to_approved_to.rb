class RenameColumnClaimedByToApprovedTo < ActiveRecord::Migration[6.1]
  def change
    rename_column :giveaways, :claimed_by, :approved_to
  end
end
