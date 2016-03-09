require "test_helper"

class ChefTest <ActiveSupport::TestCase
  
  def setup
    @chef = Chef.new(chefname: "Robert", email: "bob@example.com")
  end
  
  test "chef should be valid" do
    assert @chef.valid?
  end
  
  test "chefname should be present" do
    @chef.chefname = " "
    assert_not @chef.valid?
  end  
  
  test "chefname not too short" do
    @chef.chefname = "a" * 2
    assert_not @chef.valid?
  end  
  
  test "chefname not too long" do
    @chef.chefname = "a" * 31
    assert_not @chef.valid?
  end  
  
  test "email should be present" do
    @chef.email = " "
    assert_not @chef.valid?
  end  
  
  test "email should be in bounds" do
    @chef.email = "a" * 30 + "@example.com"
    assert_not @chef.valid?
  end
  
  test "email address should be unique" do
    dup_chef = @chef.dup
    dup_chef.email = @chef.email.upcase
    @chef.save
    assert_not dup_chef.valid?
  end
  
  test "email validation should accept valid address" do
    valid_address = %w[user@eee.com R-TTD-DS@see.hello.org user@example.net first.last@eem.au laura.joe@monk.ca]
    valid_address.each do |va|
      @chef.email = va
      assert @chef.valid?, '#{va.inspect} should be valid'
    end
  end

  test "email validation should reject invalid address" do
    invalid_address = %w[eee@example name.first.com user@example,com]
    invalid_address.each do |ia|
      @chef.email = ia
      assert_not @chef.valid?, '#{ia.inspect} should be invalid'
    end
  end
  
end