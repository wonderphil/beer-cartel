require 'test_helper'

class BeersControllerTest < ActionController::TestCase
  
  def setup
    @beer = beers(:carlton)
  end

  test "should get new beer" do
    get :new
    assert_response :success
  end

  test "should redirect beer edit when not logged in" do
    get :edit, id: @beer
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect beer update when not logged in" do
    patch :update, id: @beer, beer: { name: @beer.name, style: @beer.style, brewery: @beer.brewery, description: @beer.description, alcohol: @beer.alcohol }
    assert_not flash.empty?
    assert_redirected_to login_url
  end
  

end
