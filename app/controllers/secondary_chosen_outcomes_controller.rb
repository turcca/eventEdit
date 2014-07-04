class SecondaryChosenOutcomesController < ApplicationController
  before_action :set_instance_variables, only: [:destroy]
  
  # DELETE /secondary_chosen_outcomes/1
  # DELETE /secondary_chosen_outcomes/1.json
  def destroy
    @secondary_chosen_outcome.destroy
    respond_to do |format|
      format.html { redirect_to events_url }
      format.js { flash[:notice] = 'Outcome removed' }
      format.json { head :no_content }
    end
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_instance_variables
      @secondary_chosen_outcome = SecondaryChosenOutcome.find(params[:id])
      @event = @secondary_chosen_outcome.secondary_prereq.event
    end
  
end
