class AttendancesController < ApplicationController
  before_action :set_attendance, only: %i[ show edit update destroy ]

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
    # Before the rescue, at the beginning of the method
    
    @stripe_amount = 500
    begin
      puts '💃'*60
      puts 'je suis dans le begin - begin'
      puts '💃'*60
      customer = Stripe::Customer.create({
      email: 'test@test.test',
      source: params[:stripeToken],
      })
      puts '🦺'*60
      puts customer.id
      puts customer
      puts '🦺'*60
      charge = Stripe::Charge.create({
      customer: customer.id,
      amount: @stripe_amount,
      description: "Achat d'un produit",
      currency: 'eur',
      })
      puts '🧖‍♀️'*60
      puts 'je suis dans le begin - end'
      puts '🧖‍♀️'*60
    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to new_event_attendance_path(params[:event_id])
      puts '👀'*60
      puts 'je suis dans le rescue'
      puts '👀'*60
    end
    @attendance = Attendance.create(attendee_id: current_user.id, event_id: params[:event_id])
    # After the rescue, if the payment succeeded
  end

  

  # GET /attendances/1 or /attendances/1.json
  def show
  end

  # GET /attendances/1/edit
  def edit
  end

  # PATCH/PUT /attendances/1 or /attendances/1.json
  def update
    respond_to do |format|
      if @attendance.update(attendance_params)
        format.html { redirect_to @attendance, notice: "Attendance was successfully updated." }
        format.json { render :show, status: :ok, location: @attendance }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @attendance.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /attendances/1 or /attendances/1.json
  def destroy
    @attendance.destroy
    respond_to do |format|
      format.html { redirect_to attendances_url, notice: "Attendance was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_attendance
      @attendance = Attendance.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    # def attendance_params
    #   params.fetch(:attendance, {})
    # end
end
