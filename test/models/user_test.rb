require "test_helper"

class UserTest < ActiveSupport::TestCase
  setup do
    @user = users(:one)
  end

  test "should be valid with all fields present and correct format" do
    assert @user.valid?
  end

  test "should validate presence of all fields" do
    [:name, :dob, :email, :phone_number, :address].each do |attr|
      original_value = @user.send(attr)
      @user.send("#{attr}=", nil)
      assert_not @user.valid?, "User should be invalid without #{attr}"
      @user.send("#{attr}=", original_value) 
    end
  end

  test "should validate email structure" do
    invalid_emails = ["user", "user@", "user@domain", "@domain.com", "user @domain.com"]
    invalid_emails.each do |email|
      @user.email = email
      assert_not @user.valid?, "User should be invalid with email: #{email}"
    end

    valid_emails = ["user@domain.com", "user.name@domain.co.uk", "user+label@domain.org"]
    valid_emails.each do |email|
      @user.email = email
      assert @user.valid?, "User should be valid with email: #{email}"
    end
  end

  test "should validate uniqueness of email" do
    duplicate_user = User.new(
      name: "Duplicate",
      dob: "1995-05-05",
      email: @user.email,
      phone_number: "555555555",
      address: "789 Pine St"
    )
    assert_not duplicate_user.valid?, "Duplicate user should be invalid"

    duplicate_user.email = @user.email.upcase
    assert_not duplicate_user.valid?, "Duplicate user with uppercase email should be invalid"
  end

  test "should raise DB constraint on duplicate email" do
    duplicate_user = User.new(
      name: "Duplicate",
      dob: "1995-05-05",
      email: @user.email,
      phone_number: "555555555",
      address: "789 Pine St"
    )
    assert_raises(ActiveRecord::RecordNotUnique) do
      duplicate_user.save(validate: false)
    end
  end
end
