class CreateMeetings < ActiveRecord::Migration
  def change
    create_table :meetings do |t|
      t.date :date
      t.text :comments

      t.timestamps null: false
    end
  end
end
