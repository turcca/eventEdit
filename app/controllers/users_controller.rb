class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :destroy]
  before_filter :is_admin!
  
  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end
  
  # GET /users/1/edit
  def edit
  end
  
  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to users_path, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    if (@user.admin && User.where("admin = ? AND id != ?", true, @user.id).empty?)
      redirect_to users_url, notice: 'Cannot delete the last admin.'
    else
      @user.destroy
      respond_to do |format|
        format.html { redirect_to users_url }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:approved, :admin)
    end
    
    def is_admin!
      if current_user.admin
        true
      else
        redirect_to events_path, notice: "You don't have rights to view the page you requested."
      end
    end
end
