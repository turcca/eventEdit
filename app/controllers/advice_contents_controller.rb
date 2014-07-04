class AdviceContentsController < ApplicationController
  before_action :set_advice_content, only: [:show, :edit, :update, :destroy]

  # GET /advice_contents
  # GET /advice_contents.json
  def index
    @advice_contents = AdviceContent.all
  end

  # GET /advice_contents/1
  # GET /advice_contents/1.json
  def show
  end

  # GET /advice_contents/new
  def new
    @advice_content = AdviceContent.new
  end

  # GET /advice_contents/1/edit
  def edit
  end

  # POST /advice_contents
  # POST /advice_contents.json
  def create
    @advice_content = AdviceContent.new(advice_content_params)
    @advice_content.build_tool

    @event = @advice_content.root.event
    respond_to do |format|
      if @advice_content.save
        format.html { redirect_to @advice_content, notice: 'Advice was successfully created.' }
        format.js   { flash[:notice] = "Advice was successfully created" }
        format.json { render action: 'show', status: :created, location: @advice_content }
      else
        format.html { render action: 'new' }
        format.json { render json: @advice_content.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /advice_contents/1
  # PATCH/PUT /advice_contents/1.json
  def update
    @event = @advice_content.root.event
    
    unless !params[:advice_content][:template] || params[:advice_content][:template].blank?
      if params[:advice_content][:template] == 'Ideology'
        pretool = Tool.find(:first, :conditions => {:name => 'TheAdvisor'})
        tool = Tool.find(:first, :conditions => {:name => 'getIdeology'})
        tool_id = tool.id
        parameter_type_id = ParameterType.find(:first, :conditions => {:name => 'ideology'}).id
        parameter_id = Parameter.find(:first, :conditions => { :tool_id => tool_id, :parameter_type_id => parameter_type_id }).id
        ParameterValue.find(:all, :conditions => {:parameter_type_id => parameter_type_id}).each do |parameter_value|
          advice_content = AdviceContent.new()
          advice_content.type = 'AdviceContentAdvice'
          advice_content.condition = 'if'
          advice_content.build_tool
          advice_content.tool.pre_tool = pretool
          advice_content.tool.tool = tool
          advice_content.tool.save
          chosen_parameter = advice_content.tool.chosen_parameters.first
          chosen_parameter.parameter_id = parameter_id
          chosen_parameter.parameter_value_id = parameter_value.id
          chosen_parameter.save
          advice_content.parent = @advice_content
          advice_content.save
        end
      elsif params[:advice_content][:template] == 'Skill 2'
        pretool = Tool.find(:first, :conditions => {:name => 'TheAdvisor'})
        tool = Tool.find(:first, :conditions => {:name => 'getStat'})
        tool_id = tool.id
        advice_content = AdviceContent.new()
        advice_content.type = 'AdviceContentAdvice'
        advice_content.condition = 'if'
        advice_content.build_tool
        advice_content.tool.pre_tool = pretool
        advice_content.tool.tool = tool
        advice_content.tool.save
        advice_content.equality = '>='
        advice_content.parent = @advice_content
        advice_content.save
        advice_content2 = AdviceContent.new()
        advice_content2.type = 'AdviceContentAdvice'
        advice_content2.condition = 'if'
        advice_content2.build_tool
        advice_content2.tool.pre_tool = pretool
        advice_content2.tool.tool = tool
        advice_content2.tool.save
        advice_content2.equality = '<'
        advice_content2.parent = @advice_content
        advice_content2.save
      elsif params[:advice_content][:template] == 'Skill 3'
        pretool = Tool.find(:first, :conditions => {:name => 'TheAdvisor'})
        tool = Tool.find(:first, :conditions => {:name => 'getStat'})
        tool_id = tool.id
        advice_content = AdviceContent.new()
        advice_content.type = 'AdviceContentAdvice'
        advice_content.condition = 'if'
        advice_content.build_tool
        advice_content.tool.pre_tool = pretool
        advice_content.tool.tool = tool
        advice_content.tool.save
        advice_content.equality = '>='
        advice_content.parent = @advice_content
        advice_content.save
        advice_content2 = AdviceContent.new()
        advice_content2.type = 'AdviceContentAdvice'
        advice_content2.condition = 'if'
        advice_content2.build_tool
        advice_content2.tool.pre_tool = pretool
        advice_content2.tool.tool = tool
        advice_content2.tool.save
        advice_content2.equality = '>='
        advice_content2.parent = @advice_content
        advice_content2.save
        advice_content3 = AdviceContent.new()
        advice_content3.type = 'AdviceContentAdvice'
        advice_content3.condition = 'if'
        advice_content3.build_tool
        advice_content3.tool.pre_tool = pretool
        advice_content3.tool.tool = tool
        advice_content3.tool.save
        advice_content3.equality = '<'
        advice_content3.parent = @advice_content
        advice_content3.save
      end
    end 
    
    respond_to do |format|
      if @advice_content.update(advice_content_params)
        format.html { redirect_to @advice_content, notice: 'Advice content was successfully updated.' }
        format.js   { flash[:notice] = "Advice was successfully saved" }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @advice_content.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /advice_contents/1
  # DELETE /advice_contents/1.json
  def destroy
    @event = @advice_content.root.event
    @id = @advice_content.id
    @advice_content.destroy
    respond_to do |format|
      format.html { redirect_to advice_contents_url }
      format.js   { flash[:notice] = "Advice was successfully destroyed" }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_advice_content
      @advice_content = AdviceContent.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def advice_content_params
      params.require(:advice_content).permit(:ancestry, :type, :condition, :tool_id, :equality, :value, :and, :text, :event_id, :parent_id, :content_choice_id, :template, 
                                      :tool_attributes => [:id, :tool_id, :pre_tool_id, :chosen_parameters_attributes => [:id, :chosen_tool_id, :parameter_value_id, :custom_value, :parameter_id]])
    end
end
