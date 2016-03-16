class ChefsController < ApplicationController
  
  def index
    @chefs = Chef.paginate(page: params[:page], per_page: 3)
  end
  
  def show
    @chef = Chef.find(params[:id])
    @recipes = @chef.recipes.paginate(page: params[:page], per_page: 3)
  end
  
  def new
    @chef = Chef.new
  end
  
  def create
    @chef = Chef.new(chef_params)
    if @chef.save
      flash[:success] = "Your account is registered"
      redirect_to recipes_path
    else
      flash[:danger] = "Please try again"
      render 'new'
    end
  end

  def edit
    @chef = Chef.find(params[:id])
  end

  def update
    @chef = Chef.find(params[:id])
    if @chef.update(chef_params)
      flash[:success] = "Your account is updated"
      redirect_to recipes_path
    else
      flash[:danger] = "Please try again"
      render 'edit'
    end
  end

  private
  
    def chef_params
      params.require(:chef).permit(:chefname, :email, :password)
    end
  


end