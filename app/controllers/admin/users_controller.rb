class Admin::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :is_admin?

  def index
  end

  def show
    puts current_user
    puts current_user.id
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
