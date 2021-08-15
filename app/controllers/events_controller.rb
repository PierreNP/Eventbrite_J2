class EventsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  # GET /events or /events.json
  def index
    if current_user && current_user.is_admin? && params_user_id
      @events = User.find(params_user_id).events.where(is_validated:true)
    elsif params_user_id && params_user_id.to_i == current_user.id
      @events = current_user.events.where(is_validated:true)
    elsif params_user_id && params_user_id.to_i != current_user.id 
      redirect_to root_path
    else
      @events= Event.where(is_validated:true)
    end
  end

  def show
      @event = Event.find(params[:id])
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(admin_id:current_user.id)
    @event.update(post_params)

    if @event.save
      redirect_to root_path
    end
  end


  def edit
  end


  def update
   
  end

  def destroy

  end

  private
    # Use callbacks to share common setup or constraints between actions.


    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:event).permit(:title, :description, :location, :duration, :price, :start_date)
    end
end
