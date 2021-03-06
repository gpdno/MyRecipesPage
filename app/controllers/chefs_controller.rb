class ChefsController < ApplicationController
  before_action :set_chef, only: [:show, :edit, :update]
  before_action :require_same_user, only: [:edit, :update]
  
  def index
    @chefs = Chef.paginate(page: params[:page], per_page: 3)
  end
  
  def show
    @recipes = @chef.recipes.paginate(page: params[:page], per_page: 3)
  end
  
  def new
    @chef = Chef.new
  end
  
  def create
    @chef = Chef.new(chef_params)
    if @chef.save
      flash[:success] = "Your account is registered"
      session[:chef_id] = @chef.id
      redirect_to recipes_path
    else
      flash[:danger] = "Please try again"
      render 'new'
    end
  end

  def edit

  end

  def update
    if @chef.update(chef_params)
      flash[:success] = "Your account is updated"
      redirect_to chef_path(@chef)
    else
      flash[:danger] = "Please try again"
      render 'edit'
    end
  end

  private
  
    def chef_params
      params.require(:chef).permit(:chefname, :email, :password)
    end
    
    def set_chef
      @chef = Chef.find(params[:id])
    end
    
    def require_same_user
      if current_user != @chef
        flash[:danger] = "Unable to edit other users"
        redirect_to chef_path
      end
    end
end