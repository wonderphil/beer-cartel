require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  def setup
    @user = User.new(first_name: "Example",
    #				 middle_name: "middle",
    				 last_name: "User",
    				 email: "user1@example.com",
   # 				 address1: "1 somewhere st",
   # 				 address2: "ASD",
   # 				 city: "Mel",
    				 country: "Aus",
    				 postcode: "3204",
   #         state: "Vic",
   # 				 admin: false,
   # 				 activated: true,
    				 password: "F0obar!",
    				 password_confirmation: "F0obar!" )
  end

  test "should be valid" do
    assert @user.valid?
  end
  
  test "first name should be present" do
    @user.first_name = "     "
    assert_not @user.valid?
  end
  
  test "last name should be present" do
    @user.last_name = "     "
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = "     "
    assert_not @user.valid?
  end
  
  test "first name should not be too long" do
    @user.first_name = "a" * 31
    assert_not @user.valid?
  end

  test "last name should not be too long" do
    @user.last_name = "a" * 31
    assert_not @user.valid?
  end

  test "email should not be too long" do
    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end

  test "email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end
  
  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end
  
  test "email addresses should be saved as lower-case" do
    mixed_case_email = "Foo@ExAMPle.CoM"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end
  
  test "email addresses should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end
  
  test "password should have min length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end

  test "postcode should not be too long" do
    @user.postcode = "1" * 7
    assert_not @user.valid?
  end

  test "postcode should have min length" do
    @user.postcode =  "1" * 2
    assert_not @user.valid?
  end

  test "authenticated? should return false for a user with nil digest" do
    assert_not @user.authenticated?(:remember, '')
  end

end
