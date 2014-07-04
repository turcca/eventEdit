class ParameterValuesController < ApplicationController
  before_action :set_parameter_value, only: [:show, :edit, :update, :destroy]
  before_filter :is_admin!

  # GET /parameter_values
  # GET /parameter_values.json
  def index
    @parameter_values = ParameterValue.all
  end

  # GET /parameter_values/1
  # GET /parameter_values/1.json
  def show
  end

  # GET /parameter_values/new
  def new
    @parameter_value = ParameterValue.new
  end

  # GET /parameter_values/1/edit
  def edit
  end

  # POST /parameter_values
  # POST /parameter_values.json
  def create
    @parameter_value = ParameterValue.new(parameter_value_params)

    respond_to do |format|
      if @parameter_value.save
        format.html { redirect_to @parameter_value, notice: 'Parameter value was successfully created.' }
        format.json { render action: 'show', status: :created, location: @parameter_value }
      else
        format.html { render action: 'new' }
        format.json { render json: @parameter_value.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /parameter_values/1
  # PATCH/PUT /parameter_values/1.json
  def update
    respond_to do |format|
      if @parameter_value.update(parameter_value_params)
        format.html { redirect_to @parameter_value, notice: 'Parameter value was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @parameter_value.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /parameter_values/1
  # DELETE /parameter_values/1.json
  def destroy
    @parameter_value.destroy
    respond_to do |format|
      format.html { redirect_to parameter_values_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_parameter_value
      @parameter_value = ParameterValue.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def parameter_value_params
      params.require(:parameter_value).permit(:parameter_type_id, :name, :tooltip)
    end
    
    def is_admin!
      if current_user.admin
        true
      else
        redirect_to events_path, notice: "You don't have rights to view the page you requested."
      end
    end
end
