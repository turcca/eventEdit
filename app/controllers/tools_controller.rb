class ToolsController < ApplicationController
  before_action :set_tool, only: [:show, :edit, :update, :destroy]
  before_filter :is_admin!
  
  # GET /tools
  # GET /tools.json
  def index
    @tools = Tool.all
  end

  # GET /tools/1
  # GET /tools/1.json
  def show
  end

  # GET /tools/new
  def new
    @tool = Tool.new
    i = @tool.parameters.count
    2.times { 
      i += 1
      @tool.parameters.build(:order_number => i)
    }
    @pre_tool_association = PreToolAssociation.new(:tool_id => @tool.id)
  end

  # GET /tools/1/edit
  def edit
    i = @tool.parameters.count
    2.times { 
      i += 1
      @tool.parameters.build(:order_number => i)
    }
    @pre_tool_association = PreToolAssociation.new(:tool_id => @tool.id)
  end

  # POST /tools
  # POST /tools.json
  def create
    @tool = Tool.new(tool_params)

    respond_to do |format|
      if @tool.save
        format.html { redirect_to tools_path, notice: 'Tool was successfully created.' }
        format.json { render action: 'show', status: :created, location: @tool }
      else
        format.html { render action: 'new' }
        format.json { render json: @tool.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tools/1
  # PATCH/PUT /tools/1.json
  def update
    respond_to do |format|
      if @tool.update(tool_params)
        format.html { redirect_to tools_path, notice: 'Tool was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @tool.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tools/1
  # DELETE /tools/1.json
  def destroy
    @tool.destroy
    respond_to do |format|
      format.html { redirect_to tools_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tool
      @tool = Tool.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tool_params
      params.require(:tool).permit(:name, :tooltype, :booleanreturn, :character, :location, :trigger, :probability, :content_condition, :content_effect, :advice, :is_pre_tool, :system, :tooltip,
                                   :parameters_attributes => [:id, :tool_id, :parameter_type_id, :order_number], :pre_tool_associations_attributes => [:id, :pre_tool_id, :tool_id, :enabled])
    end
    
    def is_admin!
      if current_user.admin
        true
      else
        redirect_to events_path, notice: "You don't have rights to view the page you requested."
      end
    end
end
