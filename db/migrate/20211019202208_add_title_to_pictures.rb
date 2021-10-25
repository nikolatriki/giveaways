class AddTitleToPictures < ActiveRecord::Migration[6.1]
  def change
    add_column :pictures, :title, :string
  end
end
