class AddMeetingBackgroundToMeetings < ActiveRecord::Migration
  def change
    add_column :meetings, :meeting_background, :string
  end
end
