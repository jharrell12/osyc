class MembershipsController < ApplicationController
  before_action :set_membership, only: %i[ show edit update destroy ]
  #before_action :persist_search_params, only: :index

  # GET /memberships or /memberships.json
  def index
    @memberships = Membership.joins(:people).includes(:people, :emails, :phones).order(:id)
    @memberships = @memberships.where("people.last_name like :name OR people.first_name like :name", name: params.dig(:search,:name).to_s + '%')
  end

  # GET /memberships/1 or /memberships/1.json
  def show
  end

  # GET /memberships/new
  def new
    @membership = Membership.new
    p1 = @membership.people.build
    p1.addresses.build
    p1.emails.build
    p1.phones.build

    p2 = @membership.people.build
    p2.emails.build
    p2.phones.build    
    p2.addresses.build
  end

  # GET /memberships/1/edit
  def edit
  end

  # POST /memberships or /memberships.json
  def create
    @membership = Membership.new(membership_params)
    if new_person_params(0).values.any?(&:present?)
      person = @membership.people.build(new_person_params(0))
      person.emails.build(new_email_params(0).merge(label: :personal))  if new_email_params(0).values.any?(&:present?)
      person.phones.build(new_phone_params(0).merge(label: :cell)) if new_phone_params(0).values.any?(&:present?)
      person.addresses.build(new_address_params.merge(label: :mailing)) if new_address_params.values.any?(&:present?)
    else
      @membership.errors.add(:last_name, 'Person 1 is required')
    end

    if new_person_params(1).values.any?{|v| v.present?} 
      person = @membership.people.build(new_person_params(1))
      person.emails.build(new_email_params(1).merge(label: :personal))  if new_email_params(1).values.any?(&:present?)
      person.phones.build(new_phone_params(1).merge(label: :cell)) if new_phone_params(1).values.any?(&:present?)
    end

    respond_to do |format|
      if @membership.errors.empty? && @membership.save
        #format.html { redirect_to new_person_path(membership_id: @membership.id), notice: "Membership was successfully created." }
        format.html { redirect_to memberships_path, notice: "Membership #{@membership.id} was successfully created." }
        format.json { render :show, status: :created, location: @membership }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @membership.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /memberships/1 or /memberships/1.json
  def update
    respond_to do |format|
      if @membership.update(membership_params)
        format.html { redirect_to membership_url(@membership), notice: "Membership was successfully updated." }
        format.json { render :show, status: :ok, location: @membership }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @membership.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /memberships/1 or /memberships/1.json
  def destroy
    @membership.destroy!

    respond_to do |format|
      format.html { redirect_to memberships_url, notice: "Membership was successfully deleted." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_membership
      @membership = Membership.includes(:people).find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def membership_params
      params.require(:membership).permit(:start_date, :end_date, :status, :boats, :slip_assignment, :children)
    end

    def new_person_params(n)
      params.require(:people).require(n.to_s).permit(:last_name, :first_name, :dob)
    end

    def new_email_params(n)
      params.require(:emails).require(n.to_s).permit(:address)
    end

    def new_phone_params(n)
      params.require(:phones).require(n.to_s).permit(:number)
    end

    def new_address_params
      params.require(:address).permit(:street, :city, :state, :zipcode)
    end

end
