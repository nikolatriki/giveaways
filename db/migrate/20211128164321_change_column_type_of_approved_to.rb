class ChangeColumnTypeOfApprovedTo < ActiveRecord::Migration[6.1]
  def change
    change_column :giveaways, :approved_to, :string
  end
end
