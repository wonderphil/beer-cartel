class CreateBeers < ActiveRecord::Migration
  def change
    create_table :beers do |t|
      t.string :name
      t.string :style
      t.string :brewery
      t.string :brewery_url
      t.text :description
      t.decimal :alcohol
      t.string :picture

      t.timestamps null: false
    end
    add_index :beers, :name, unique: true
  end
end
 