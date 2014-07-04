class ChosenToolsController < ApplicationController
  before_action :set_chosen_tool, only: [:show, :edit, :update, :destroy]
  before_filter :is_admin!

  # GET /chosen_tools
  # GET /chosen_tools.json
  def index
    @chosen_tools = ChosenTool.all
  end

  # GET /chosen_tools/1
  # GET /chosen_tools/1.json
  def show
  end

  # GET /chosen_tools/new
  def new
    @chosen_tool = ChosenTool.new
  end

  # GET /chosen_tools/1/edit
  def edit
  end

  # POST /chosen_tools
  # POST /chosen_tools.json
  def create
    @chosen_tool = ChosenTool.new(chosen_tool_params)
    respond_to do |format|
      if @chosen_tool.save
        format.html { redirect_to @chosen_tool, notice: 'Chosen tool was successfully created.' }
        format.json { render action: 'show', status: :created, location: @chosen_tool }
      else
        format.html { render action: 'new' }
        format.json { render json: @chosen_tool.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /chosen_tools/1
  # PATCH/PUT /chosen_tools/1.json
  def update
    respond_to do |format|
      if @chosen_tool.update(chosen_tool_params)
        format.html { redirect_to @chosen_tool, notice: 'Chosen tool was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @chosen_tool.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /chosen_tools/1
  # DELETE /chosen_tools/1.json
  def destroy
    @chosen_tool.destroy
    respond_to do |format|
      format.html { redirect_to chosen_tools_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_chosen_tool
      @chosen_tool = ChosenTool.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def chosen_tool_params
      params.require(:chosen_tool).permit(:tool_id, :pre_tool_id, :chosen_parameters_attributes => [:id, :chosen_tool_id, :parameter_value_id, :custom_value, :parameter_id])
    end
    
    def is_admin!
      if current_user.admin
        true
      else
        redirect_to events_path, notice: "You don't have rights to view the page you requested."
      end
    end
end
