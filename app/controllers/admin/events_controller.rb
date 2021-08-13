class Admin::EventsController < ApplicationController
  before_action :authenticate_user!
  before_action :is_admin?

  def index
    @all_events = Event.all
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
    @event = Event.find(params[:id])
    puts '*'*60
    puts params
    puts params[:is_validated]
    puts params[:is_validated].class
    puts '*'*60
    @event.update(is_validated:params[:is_validated])
    redirect_to admin_events_path
  end

  def update_all
    @events = Event.all
    @events.each do |event|
      event.is_validated = true
    end
  end

  def destroy
  end

  private

  def post_params_event
    params.require(:event).permit(:is_validated)
  end
end
