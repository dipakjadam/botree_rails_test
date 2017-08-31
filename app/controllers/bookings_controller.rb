class BookingsController < ApplicationController
  before_action :set_booking, only: [:show, :edit, :update, :destroy]
  before_action :set_customer
  before_action :check_cleaner_available, only: [:create]

  # GET /bookings
  # GET /bookings.json
  def index
    @bookings = @customer.bookings
  end

  # GET /bookings/1
  # GET /bookings/1.json
  def show
  end

  # GET /bookings/new
  def new
    @booking = @customer.bookings.new
  end

  # GET /bookings/1/edit
  def edit
  end

  # POST /bookings
  # POST /bookings.json
  def create
    respond_to do |format|
      if @booking.save
        CleanerMailer.assign_work(@booking.cleaner)
        format.html { redirect_to customer_booking_path(@customer,@booking), notice: 'Booking was successfully created.' }
        format.json { render :show, status: :created, location: @booking }
      else
        format.html { render :new }
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bookings/1
  # PATCH/PUT /bookings/1.json
  def update
    respond_to do |format|
      if @booking.update(booking_params)
        format.html { redirect_to @booking, notice: 'Booking was successfully updated.' }
        format.json { render :show, status: :ok, location: @booking }
      else
        format.html { render :edit }
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bookings/1
  # DELETE /bookings/1.json
  def destroy
    @booking.destroy
    respond_to do |format|
      format.html { redirect_to customer_bookings_path(@customer), notice: 'Booking was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_booking
      @booking = Booking.find(params[:id])
    end

    def set_customer
      @customer = Customer.find(params[:customer_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def booking_params
      params.require(:booking).permit(:customer_id, :cleaner_id, :date)
    end

    def check_cleaner_available
      @booking = @customer.bookings.new(booking_params)
      booking = Booking.where(date: @booking.date, cleaner_id: booking_params[:cleaner_id]).first
      if booking.present?
        flash[:error] = "Sorry we could not fulfill your request"
        redirect_to customer_bookings_path(@customer.id) and return
      end
    end
end
