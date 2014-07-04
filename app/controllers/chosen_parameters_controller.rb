class ChosenParametersController < ApplicationController
  before_action :set_chosen_parameter, only: [:show, :edit, :update, :destroy]
  before_filter :is_admin!

  # GET /chosen_parameters
  # GET /chosen_parameters.json
  def index
    @chosen_parameters = ChosenParameter.all
  end

  # GET /chosen_parameters/1
  # GET /chosen_parameters/1.json
  def show
  end

  # GET /chosen_parameters/new
  def new
    @chosen_parameter = ChosenParameter.new
  end

  # GET /chosen_parameters/1/edit
  def edit
  end

  # POST /chosen_parameters
  # POST /chosen_parameters.json
  def create
    @chosen_parameter = ChosenParameter.new(chosen_parameter_params)

    respond_to do |format|
      if @chosen_parameter.save
        format.html { redirect_to @chosen_parameter, notice: 'Chosen parameter was successfully created.' }
        format.json { render action: 'show', status: :created, location: @chosen_parameter }
      else
        format.html { render action: 'new' }
        format.json { render json: @chosen_parameter.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /chosen_parameters/1
  # PATCH/PUT /chosen_parameters/1.json
  def update
    respond_to do |format|
      if @chosen_parameter.update(chosen_parameter_params)
        format.html { redirect_to @chosen_parameter, notice: 'Chosen parameter was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @chosen_parameter.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /chosen_parameters/1
  # DELETE /chosen_parameters/1.json
  def destroy
    @chosen_parameter.destroy
    respond_to do |format|
      format.html { redirect_to chosen_parameters_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_chosen_parameter
      @chosen_parameter = ChosenParameter.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def chosen_parameter_params
      params.require(:chosen_parameter).permit(:chosen_tool_id, :parameter_value_id, :custom_value, :parameter_id)
    end
    
    def is_admin!
      if current_user.admin
        true
      else
        redirect_to events_path, notice: "You don't have rights to view the page you requested."
      end
    end
end
