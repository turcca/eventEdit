class ParameterTypesController < ApplicationController
  before_action :set_parameter_type, only: [:show, :edit, :update, :destroy]
  before_filter :is_admin!

  # GET /parameter_types
  # GET /parameter_types.json
  def index
    @parameter_types = ParameterType.all
  end

  # GET /parameter_types/1
  # GET /parameter_types/1.json
  def show
  end

  # GET /parameter_types/new
  def new
    @parameter_type = ParameterType.new
    10.times { @parameter_type.parameter_values.build }
  end

  # GET /parameter_types/1/edit
  def edit
    @parameter_type.parameter_values.build
    10.times { @parameter_type.parameter_values.build }
  end

  # POST /parameter_types
  # POST /parameter_types.json
  def create
    @parameter_type = ParameterType.new(parameter_type_params)
    respond_to do |format|
      if @parameter_type.save!
        format.html { redirect_to parameter_types_path, notice: 'Parameter type was successfully created.' }
        format.json { render action: 'show', status: :created, location: @parameter_type }
      else
        format.html { render action: 'new' }
        format.json { render json: @parameter_type.errors, status: :unprocessable_entity }
        puts @parameter_type.errors.inspect.to_s
        puts @parameter_type.valid?
      end
    end
  end

  # PATCH/PUT /parameter_types/1
  # PATCH/PUT /parameter_types/1.json
  def update
    respond_to do |format|
      if @parameter_type.update(parameter_type_params)
        format.html { redirect_to parameter_types_path, notice: 'Parameter type was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @parameter_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /parameter_types/1
  # DELETE /parameter_types/1.json
  def destroy
    @parameter_type.destroy
    respond_to do |format|
      format.html { redirect_to parameter_types_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_parameter_type
      @parameter_type = ParameterType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def parameter_type_params
      params.require(:parameter_type).permit(:name, :is_custom_type, :needs_quotation,:system, :parameter_values_attributes => [:id, :name, :parameter_type_id, :tooltip])
    end
    
    def is_admin!
      if current_user.admin
        true
      else
        redirect_to events_path, notice: "You don't have rights to view the page you requested."
      end
    end
end
