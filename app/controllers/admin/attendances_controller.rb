class Admin::AttendancesController < ApplicationController
  before_action :authenticate_user!
  before_action :is_admin?
  
  def index
  end

  def show
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
