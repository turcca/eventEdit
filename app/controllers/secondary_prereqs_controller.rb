class SecondaryPrereqsController < ApplicationController
  before_action :set_secondary_prereq, only: [:show, :edit, :update, :destroy]

  # GET /secondary_prereqs
  # GET /secondary_prereqs.json
  def index
    @secondary_prereqs = SecondaryPrereq.all
  end

  # GET /secondary_prereqs/1
  # GET /secondary_prereqs/1.json
  def show
  end

  # GET /secondary_prereqs/new
  def new
    @secondary_prereq = SecondaryPrereq.new
  end

  # GET /secondary_prereqs/1/edit
  def edit
  end

  # POST /secondary_prereqs
  # POST /secondary_prereqs.json
  def create
    @secondary_prereq = SecondaryPrereq.new(secondary_prereq_params)
    @event = Event.find params[:secondary_prereq][:event_id]

    respond_to do |format|
      if @secondary_prereq.save
        format.html { redirect_to @secondary_prereq, notice: 'Secondary prereq was successfully created.' }
        format.js   { flash[:notice] = "Event link was successfully created" }
        format.json { render action: 'show', status: :created, location: @secondary_prereq }
      else
        format.html { render action: 'new' }
        format.json { render json: @secondary_prereq.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /secondary_prereqs/1
  # PATCH/PUT /secondary_prereqs/1.json
  def update
    @event = Event.find @secondary_prereq.event_id
    unless params[:secondary_prereq][:secondary_chosen_outcome_id].blank?
      @secondary_prereq.secondary_chosen_outcomes << SecondaryChosenOutcome.new(:secondary_prereq_id => @secondary_prereq.id, :content_outcome_id => params[:secondary_prereq][:secondary_chosen_outcome_id])
      puts 'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA ' + params[:secondary_prereq][:secondary_chosen_outcome_id]
      params[:secondary_prereq][:secondary_chosen_outcome_id] = nil
    end
    respond_to do |format|
      if @secondary_prereq.update(secondary_prereq_params)
        format.html { redirect_to @secondary_prereq, notice: 'Secondary prereq was successfully updated.' }
        format.js   { flash[:notice] = "Event link was successfully updated" }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @secondary_prereq.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /secondary_prereqs/1
  # DELETE /secondary_prereqs/1.json
  def destroy
    @event = Event.find @secondary_prereq.event_id
    @secondary_prereq.destroy
    respond_to do |format|
      format.html { redirect_to secondary_prereqs_url }
      format.js   { flash[:notice] = "Event link was successfully destroyed" }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_secondary_prereq
      @secondary_prereq = SecondaryPrereq.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def secondary_prereq_params
      params.require(:secondary_prereq).permit(:event_id, :prereq_id, :p, :secondary_chosen_outcome_id)
    end
end
