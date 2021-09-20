class AddUserToGiveaways < ActiveRecord::Migration[6.1]
  def change
    add_reference :giveaways, :user, foreign_key: true
  end
end
