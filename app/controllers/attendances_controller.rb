class AttendancesController < ApplicationController

  before_action :authenticate_user!
  before_action :is_attending?, only: [:new, :create]

  # GET /attendances or /attendances.json
  def index
    @attendances = Attendance.all
  end

  # GET /attendances/new
  def new
    @attendance = Attendance.new
    @event = Event.find(params[:event_id])
  end

  def create
      @event = Event.find(params[:event_id])
      @amount = @event.price * 100
      @attendance = Attendance.new

    if (@amount > 0)
      begin
      customer = Stripe::Customer.create({
        email: params[:stripeEmail],
        source: params[:stripeToken],
      })
    
      charge = Stripe::Charge.create({
        customer: customer.id,
        amount: @amount,
        description: 'Rails Stripe customer',
        currency: 'eur',
      })

      @attendance.update(event_id:@event.id, attendee_id:current_user.id, stripe_customer_id:customer.id)

    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to new_event_attendance_path
    end

    else
        @attendance.update(event_id:@event.id, attendee_id:current_user.id, stripe_customer_id:"free event so no Stripe ID")
    end
    
  end

  # GET /attendances/1 or /attendances/1.json
  def show
  end

  # GET /attendances/1/edit
  def edit

  end

  # PATCH/PUT /attendances/1 or /attendances/1.json
  def update
  end

  # DELETE /attendances/1 or /attendances/1.json
  def destroy
    puts "👀"*60
    puts params
    puts "👀"*60

    @attendance = Attendance.find(params[:id])
    @event = Event.find(@attendance.event_id)
    @attendance.destroy

    redirect_to event_path(@event.id)

  end

  private

end
