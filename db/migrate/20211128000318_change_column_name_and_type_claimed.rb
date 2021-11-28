class ChangeColumnNameAndTypeClaimed < ActiveRecord::Migration[6.1]
  def change
    remove_column :giveaways, :claimed, :boolean, default: false
    add_column :giveaways, :claimed_by, :bigint
  end
  
end
