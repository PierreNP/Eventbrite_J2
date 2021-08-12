class EventsController < ApplicationController
  before_action :authenticate_user!, except: :index

  # GET /events or /events.json
  def index
    if params[:user_id] && params[:user_id].to_i == current_user.id
      @events = current_user.events
    elsif params[:user_id] && params[:user_id].to_i != current_user.id 
      redirect_to root_path
    else
      @events= Event.all  
    end
  end

  # GET /events/1 or /events/1.json
  def show
    if params[:user_id] && params[:user_id].to_i == current_user.id
      @event= Event.find(params[:id])
    elsif params[:user_id] && params[:user_id].to_i != current_user.id 
      redirect_to root_path
    else
      @event = Event.find(params[:id])
    end
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events or /events.json
  def create
    @event = Event.new(admin_id:current_user.id)
    @event.update(post_params)

    if @event.save
      redirect_to root_path
    end
  end

  # PATCH/PUT /events/1 or /events/1.json

  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: "Event was successfully updated." }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1 or /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: "Event was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.


    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:event).permit(:title, :description, :location, :duration, :price, :start_date)
    end
end
