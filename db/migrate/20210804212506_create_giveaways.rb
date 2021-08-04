class CreateGiveaways < ActiveRecord::Migration[6.1]
  def change
    create_table :giveaways do |t|
      t.string :title
      t.text :description
      t.string :location

      t.timestamps
    end
  end
end
