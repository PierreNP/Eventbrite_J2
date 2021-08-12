class AttendancesController < ApplicationController

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
      puts "👀"*20
      puts @amount
      puts @amount.class
      puts "👀"*20

    if (@amount > 0)

      puts "👄"*40
      puts 'je suis dans le IF'
      puts "👄"*40

      begin
        puts 'je rentre dans le IF AMOUNT > 0'
        puts "😈"*100
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
      puts "💩"*40
      puts 'je suis dans le ELSE'
      @attendance.update(event_id:@event.id, attendee_id:current_user.id, stripe_customer_id:"free event so no Stripe ID")
      puts "💩"*40

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

  end

  private
    # Use callbacks to share common setup or constraints between actions.
  

    # Only allow a list of trusted parameters through.
    # def attendance_params
    #   params.fetch(:attendance, {})
    # end
end
