class Review < ActiveRecord::Base
	validates :rating, presence: true
	validates :comment, presence: true
	validates :beer_id, :user_id, presence: true
	validates :rating, numericality: {
    	only_integer: true,
    	greater_than_or_equal_to: 1,
    	less_than_or_equal_to: 5,
    	message: "can only be a whole number between 1 and 5"
  	}

	belongs_to :user
	belongs_to :beer

end
