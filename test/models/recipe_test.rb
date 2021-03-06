require 'test_helper'

class RecipeTest <ActiveSupport::TestCase

  def setup
    @chef = Chef.create(chefname: "Bob", email: "bob@example.com")
    @recipe = @chef.recipes.build(name: "Chicken Salad", summary: "This is a low-cal chicken salad", 
    description: "This chickne salad is a quick and easy recipe to make.  In under 10 minutes you can
    be eating a light and health meal.  For more infromation be sure to check out the blog.")
  end

  test "recipe should be valid" do
    assert @recipe.valid?
  end
  
  test "chef_id should be present" do
    @recipe.chef_id = nil
    assert_not @recipe.valid?
  end
  
  test "name should be present" do
    @recipe.name = " "
    assert_not @recipe.valid?
  end
  
  test "name lenght should not be too long" do
    @recipe.name = "a" * 51
    assert_not @recipe.valid?
  end
  
  test "name length should not be too short" do
    @recipe.name = "a" * 4
    assert_not @recipe.valid?
  end
  
  test "summary should be present" do
    @recipe.summary = " "
    assert_not @recipe.valid?
  end  
  
   test "summary lenght should not be too long" do
    @recipe.summary = "a" * 151
    assert_not @recipe.valid?
  end
  
  test "summary length should not be too short" do
    @recipe.summary = "a" * 19
    assert_not @recipe.valid?
  end
  
  test "description should be present" do
    @recipe.description = " "
    assert_not @recipe.valid?
  end  
  
   test "description lenght should not be too long" do
    @recipe.description = "a" * 501
    assert_not @recipe.valid?
  end
  
  test "description length should not be too short" do
    @recipe.description = "a" * 19
    assert_not @recipe.valid? 
  end

end