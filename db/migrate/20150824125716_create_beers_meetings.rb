class CreateBeersMeetings < ActiveRecord::Migration
  def change
    create_table :beers_meetings, :id => false do |t|
    	t.integer :beer_id
    	t.integer :meeting_id
    end
  end
end
