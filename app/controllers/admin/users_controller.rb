class Admin::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :is_admin?

  def index
    @all_users = User.all
  end

  def show
    puts current_user
    puts current_user.id
  end

  def new
    @user = User.new
  end

  def create
    puts params
    @user = User.create(post_params)
    if @user.save
      redirect_to admin_users_path
    end
    #else, blablabla
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(post_params_user)
    redirect_to admin_users_path
  
    
  end

  def destroy
    @user = User.find(params[:id])
    @user.delete
    redirect_to admin_users_path
  end 

  private

  def post_params_user
    params.require(:user).permit(:first_name, :last_name, :email, :password, :is_admin)
  end



end
