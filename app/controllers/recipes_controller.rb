class RecipesController <ApplicationController
  before_action :set_recipe, only: [:show, :edit, :update, :like]
  before_action :require_user, except: [:index, :show]
  before_action :require_same_user, only: [:edit, :update]
  
  def index
   # @recipes = Recipe.all.sort_by{|likes| likes.thumbs_up_total}.reverse
    @recipes = Recipe.paginate(page: params[:page], per_page: 3)
  end
  
  def show
    
  end
  
  def new
    @recipe = Recipe.new
  end
  
  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.chef = current_user
    
    if @recipe.save
      flash[:success] = "The recipe was created"
      redirect_to recipes_path
    else
      render :new
    end
  end
  
  def edit

  end
    
  def update
    if @recipe.update(recipe_params)
      flash[:success] = "The recipe was updated"
      redirect_to recipe_path(@recipe)
    else
      render :edit
    end
  end
  
  def like
    like = Like.create(like: params[:like], chef: current_user, recipe: @recipe)
    if like.valid?
      flash[:success] = "Your vote was recorded"
      redirect_to :back
    else
      flash[:warning] = "Sorry, you only have one vote per item"
      redirect_to :back
    end
  end
  
  private
  
    def recipe_params
      params.require(:recipe).permit(:name, :summary, :description, :picture)
    end
    
    def set_recipe
      @recipe = Recipe.find(params[:id])
    end
    
    def require_same_user
      if current_user != @recipe.chef
        flash[:danger] = "Unable to edit other user's recipes"
        redirect_to root_path
      end
    end
end