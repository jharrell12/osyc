class PhonesController < ApplicationController
  before_action :set_phone, only: %i[ show edit update destroy ]

  # GET /phones or /phones.json
  def index
    @phones = Phone.all
  end

  # GET /phones/1 or /phones/1.json
  def show
  end

  # GET /phones/new
  def new
    @person = Person.find(params[:person_id])
    @phone = @person.phones.build
  end

  # GET /phones/1/edit
  def edit
  end

  # POST /phones or /phones.json
  def create
    @person = Person.find(params[:person_id])
    @phone = @person.phones.build(phone_params)

    respond_to do |format|
      if @phone.save
        format.html { redirect_to membership_url(@phone.person.membership), notice: "Phone Number was successfully created." }
        format.json { render :show, status: :created, location: @phone }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @phone.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /phones/1 or /phones/1.json
  def update
    respond_to do |format|
      if @phone.update(phone_params)
        format.html { redirect_to membership_url(@phone.person.membership), notice: "Phone Number was successfully updated." }
        format.json { render :show, status: :ok, location: @phone }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @phone.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /phones/1 or /phones/1.json
  def destroy
    @membership = @phone.person.membership
    msg = @phone.set_end_date(params[:operation])

    respond_to do |format|
      format.html { redirect_to membership_url(@membership), notice: msg }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_phone
      @phone = Phone.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def phone_params
      params.require(:phone).permit(:start_date, :end_date, :label, :number)
    end
end
