require 'test_helper'

class BeerTest < ActiveSupport::TestCase
  
  def setup
    @beer = Beer.new(name: "Beer Name", style: "Beer Style", brewery: "Beer brewery", alcohol: '0.01' )
  end

  test "should be valid" do
    assert @beer.valid?
  end

  test "name should be present" do
    @beer.name = nil
    assert_not @beer.valid?
  end

  test "style should be at most 200 characters" do
    @beer.style = "a" * 201
    assert_not @beer.valid?
  end

  test "brewery should be at most 200 characters" do
    @beer.brewery = "a" * 201
    assert_not @beer.valid?
  end

  test "alcohol should be at most 6 characters" do
    @beer.alcohol = "a" * 6
    assert_not @beer.valid?
  end


end
