require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase
  
  def setup
    @base_title = "Beer Cartel"
  end

  test "should get home" do
    get :home
    assert_response :success
    assert_select "title", "Home | #{@base_title}"
  end

  test "should get contact" do
    get :contact
    assert_response :success
    assert_select "title", "Contact Us | #{@base_title}"
  end


end
