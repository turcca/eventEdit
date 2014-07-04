class ChosenOutcomesController < ApplicationController
  before_action :set_instance_variables, only: [:destroy]
  
  # DELETE /chosen_filters/1
  # DELETE /chosen_filters/1.json
  def destroy
    @chosen_outcome.destroy
    respond_to do |format|
      format.html { redirect_to events_url }
      format.js { flash[:notice] = 'Outcome removed' }
      format.json { head :no_content }
    end
    set_outcomes
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_instance_variables
      @chosen_outcome = ChosenOutcome.find(params[:id])
      @event = @chosen_outcome.event
    end
    
    def set_outcomes
      @outcomes = []
      unless @event.parent.nil?
        @event.parent.content_root.descendants.where(:type => 'ContentEffect').each do |effect|
          if effect.tool1 && effect.tool1.tool.name == 'end'
            @outcomes << effect.parent
          end
        end
        remove_outcomes = []
        ChosenOutcome.where('event_id = ?', @event.id).each do |chosen_outcome|
          remove_outcomes << chosen_outcome.content_outcome
        end
        @outcomes = @outcomes - remove_outcomes
      end
    end
end
