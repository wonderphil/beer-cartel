class AddFavouriteBeerToUsers < ActiveRecord::Migration
  def change
    add_column :users, :favourite, :string
  end
end
