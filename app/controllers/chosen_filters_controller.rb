class ChosenFiltersController < ApplicationController
  before_action :set_instance_variables, only: [:destroy]
  
  # DELETE /chosen_filters/1
  # DELETE /chosen_filters/1.json
  def destroy
    @chosen_filter.destroy
    respond_to do |format|
      format.html { redirect_to events_url }
      format.js { flash[:notice] = 'Filter removed' }
      format.json { head :no_content }
    end
    set_filters
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_instance_variables
      @chosen_filter = ChosenFilter.find(params[:id])
      @event = @chosen_filter.event
    end
    
    def set_filters
      @filters = Filter.all
      remove_filters = []
      @event.chosen_filters.each do |chosen_filter|
        @filters.each do |filter|
          if filter.id == chosen_filter.filter_id
            remove_filters << filter
          end
        end
      end
      @filters = @filters - remove_filters
    end
end
