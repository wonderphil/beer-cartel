class AddDrunkDateToBeers < ActiveRecord::Migration
  def change
    add_column :beers, :drunk_on, :date
  end
end
