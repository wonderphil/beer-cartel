class Beer < ActiveRecord::Base
	validates :name, presence: true, length: { minimum: 2, maximum: 50 }, uniqueness: { case_sensitive: false }
	validates :alcohol, numericality: true, length: { maximum: 6 }, allow_blank: true
	validates :brewery, :brewery_url, :style, length: { minimum: 2, maximum: 200 }, allow_blank: true
	validates :description, length: { minimum: 2 }, allow_blank: true
	validate  :picture_size

  has_many :reviews, dependent: :destroy
  has_and_belongs_to_many :meetings

	before_save   :correct_case_name

  searchkick
  
	mount_uploader :picture, PictureUploader

	 private

    def correct_case_name
      self.name = name.split.map(&:capitalize)*' '
    end

    # Validates the size of an uploaded picture.
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "should be less than 5MB")
      end
    end


end
