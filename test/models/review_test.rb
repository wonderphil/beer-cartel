require 'test_helper'

class ReviewTest < ActiveSupport::TestCase
  
  def setup
    @review = Review.new(comment: "Beer review", rating: '1', user_id: '1', beer_id: '1' )
  end

  test "should be valid" do
    assert @review.valid?
  end

  test "rating should be present" do
    @review.rating = nil
    assert_not @review.valid?
  end

  test "comment should be present" do
    @review.comment = nil
    assert_not @review.valid?
  end

  test "user id should be present" do
    @review.user_id = nil
    assert_not @review.valid?
  end

  test "beer id should be present" do
    @review.beer_id = nil
    assert_not @review.valid?
  end


end
