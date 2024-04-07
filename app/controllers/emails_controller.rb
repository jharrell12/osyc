class EmailsController < ApplicationController
  before_action :set_email, only: %i[ show edit update destroy ]

  # GET /emails or /emails.json
  def index
    @emails = Email.all
  end

  # GET /emails/1 or /emails/1.json
  def show
  end

  # GET /emails/new
  def new
    @person = Person.find(params[:person_id])
    @email = @person.emails.build
  end

  # GET /emails/1/edit
  def edit
  end

  # POST /emails or /emails.json
  def create
    @person = Person.find(params[:person_id])
    @email = @person.emails.build(email_params)  

    respond_to do |format|
      if @email.save
        format.html { redirect_to membership_url(@email.person.membership), notice: "Email address was successfully created." }
        format.json { render :show, status: :created, location: @email }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @email.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /emails/1 or /emails/1.json
  def update
    respond_to do |format|
      if @email.update(email_params)
        format.html { redirect_to membership_url(@email.person.membership), notice: "Email address was successfully updated." }
        format.json { render :show, status: :ok, location: @email }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @email.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /emails/1 or /emails/1.json
  def destroy
    @membership = @email.person.membership
    #@email.destroy!
    @email.update!(end_date: Date.today)    

    respond_to do |format|
      format.html { redirect_to membership_url(@email.person.membership), notice: "Email address was deactivated." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_email
      @email = Email.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def email_params
      params.require(:email).permit(:start_date, :end_date, :label, :address)
    end
end
