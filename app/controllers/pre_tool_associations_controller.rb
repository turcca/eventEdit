class PreToolAssociationsController < ApplicationController
  before_action :set_pre_tool_association, only: [:show, :edit, :update, :destroy]
  before_filter :is_admin!

  # GET /pre_tool_associations
  # GET /pre_tool_associations.json
  def index
    @pre_tool_associations = PreToolAssociation.all
  end

  # GET /pre_tool_associations/1
  # GET /pre_tool_associations/1.json
  def show
  end

  # GET /pre_tool_associations/new
  def new
    @pre_tool_association = PreToolAssociation.new
  end

  # GET /pre_tool_associations/1/edit
  def edit
  end

  # POST /pre_tool_associations
  # POST /pre_tool_associations.json
  def create
    @pre_tool_association = PreToolAssociation.new(pre_tool_association_params)

    respond_to do |format|
      if @pre_tool_association.save
        format.html { redirect_to @pre_tool_association, notice: 'Pre tool association was successfully created.' }
        format.json { render action: 'show', status: :created, location: @pre_tool_association }
      else
        format.html { render action: 'new' }
        format.json { render json: @pre_tool_association.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pre_tool_associations/1
  # PATCH/PUT /pre_tool_associations/1.json
  def update
    respond_to do |format|
      if @pre_tool_association.update(pre_tool_association_params)
        format.html { redirect_to @pre_tool_association, notice: 'Pre tool association was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @pre_tool_association.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pre_tool_associations/1
  # DELETE /pre_tool_associations/1.json
  def destroy
    @pre_tool_association.destroy
    respond_to do |format|
      format.html { redirect_to pre_tool_associations_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pre_tool_association
      @pre_tool_association = PreToolAssociation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pre_tool_association_params
      params.require(:pre_tool_association).permit(:pre_tool_id, :tool_id, :enabled)
    end
    
    def is_admin!
      if current_user.admin
        true
      else
        redirect_to events_path, notice: "You don't have rights to view the page you requested."
      end
    end
end
