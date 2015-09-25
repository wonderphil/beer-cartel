class CreateMeetingsUsers < ActiveRecord::Migration
  def change
    create_table :meetings_users, :id => false do |t|
    	t.integer :meeting_id
    	t.integer :user_id
    end
  end
end
