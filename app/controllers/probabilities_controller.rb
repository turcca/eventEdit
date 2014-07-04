class ProbabilitiesController < ApplicationController
  before_action :set_probability, only: [:show, :edit, :update, :destroy]
  before_filter :is_admin!

  # GET /probabilities
  # GET /probabilities.json
  def index
    @probabilities = Probability.all
  end

  # GET /probabilities/1
  # GET /probabilities/1.json
  def show
  end

  # GET /probabilities/new
  def new
    @probability = Probability.new
  end

  # GET /probabilities/1/edit
  def edit
  end

  # POST /probabilities
  # POST /probabilities.json
  def create
    @probability = Probability.new(probability_params)
    @probability.build_tool1
    @probability.build_tool2
    @event = Event.find params[:probability][:event_id]

    respond_to do |format|
      if @probability.save
        format.html { redirect_to @probability, notice: 'Event was successfully saved' }
        format.js   { flash[:notice] = "Probability was successfully created" }
        format.json { render action: 'show', status: :created, location: @probability }
      else
        format.html { render action: 'new' }
        format.json { render json: @probability.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /probabilities/1
  # PATCH/PUT /probabilities/1.json
  def update
    @event = Event.find @probability.event_id
    respond_to do |format|
      if @probability.update(probability_params)
        format.html { redirect_to @probability, notice: 'Event was successfully saved' }
        format.js   { flash[:notice] = "Probability was successfully saved" }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @probability.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /probabilities/1
  # DELETE /probabilities/1.json
  def destroy
    @event = Event.find @probability.event_id
    @probability.destroy
    respond_to do |format|
      format.html { redirect_to probabilities_url }
      format.js   { flash[:notice] = "Probability was successfully destroyed" }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_probability
      @probability = Probability.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def probability_params
      params.require(:probability).permit(:condition, :tool1_id, :equality1, :value1, :andor, :tool2_id, :equality2, :value2, :p, :event_id, :rangevalue,
                                          :tool1_attributes => [:id, :tool_id, :pre_tool_id, :chosen_parameters_attributes => [:id, :chosen_tool_id, :parameter_value_id, :custom_value, :parameter_id]],
                                          :tool2_attributes => [:id, :tool_id, :pre_tool_id, :chosen_parameters_attributes => [:id, :chosen_tool_id, :parameter_value_id, :custom_value, :parameter_id]])
    end
    
    def is_admin!
      if current_user.admin
        true
      else
        redirect_to events_path, notice: "You don't have rights to view the page you requested."
      end
    end
end
