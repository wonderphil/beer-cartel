class Meeting < ActiveRecord::Base
	validates :date, presence: true
	has_and_belongs_to_many :beers
	has_and_belongs_to_many :users
	validate  :picture_size

	mount_uploader :meeting_background, MeetingBackgroundUploader


	private

    # Validates the size of an uploaded picture.
    def picture_size
      if meeting_background.size > 5.megabytes
        errors.add(:meeting_background, "should be less than 5MB")
      end
    end
end
