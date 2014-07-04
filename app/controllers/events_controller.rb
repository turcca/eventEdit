class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  # GET /events
  # GET /events.json
  def index
    @events = Event.all
    #@trees = Event.find_by_name('Testevent').subtree.arrange.to_json
    gon.jsontrees = Event.arrange_serializable
    gon.jsontrees.sort! { |a,b| a["colorfiltername"].downcase <=> b["colorfiltername"].downcase }
    #jsontrees2 = Hash.new
    #jsontrees2["name"] = "root"
    #jsontrees2["children"] = Event.arrange_serializable
    #gon.jsontrees2 = jsontrees2
  end

  # GET /events/1
  # GET /events/1.json
  def show
  end

  # GET /events/new
  def new
    @event = Event.new
    @event.build_character_tool
  end

  # GET /events/1/edit
  def edit
    @newprobability = Probability.new
    @newsecondaryprereq = SecondaryPrereq.new
    
    if @event.character_tool.nil?
      @event.build_character_tool
    end
    if @event.trigger_tool.nil?
      @event.build_trigger_tool
    end
    if @event.location_tool.nil?
      @event.build_location_tool
    end
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new
    
    respond_to do |format|
      if @event.save
        format.html { redirect_to edit_event_path(@event), notice: 'Event was successfully created.' }
        format.json { render action: 'show', status: :created, location: @event }
      else
        format.html { render action: 'new' }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    unless !params[:event][:filter_id] || params[:event][:filter_id].blank?
      @event.chosen_filters << ChosenFilter.new(:event_id => @event.id, :filter_id => params[:event][:filter_id])
      params[:event][:filter_id] = nil
    end
    unless !params[:event][:chosen_outcome_id] || params[:event][:chosen_outcome_id].blank?
      @event.chosen_outcomes << ChosenOutcome.new(:event_id => @event.id, :content_outcome_id => params[:event][:chosen_outcome_id])
      params[:event][:chosen_outcome_id] = nil
    end
    params[:event][:filter_id] = nil
    params[:event][:chosen_outcome_id] = nil
    respond_to do |format|
      if @event.update(event_params)
        format.html { flash[:notice] = "Event was successfully saved"
                      render action: 'edit' }
        format.js   { flash[:notice] = "Event was successfully saved" }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.js
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url }
      format.json { head :no_content }
    end
  end
  
  def download
    text = ''
    events = Event.all
    events.each do |event|
      
      # Add the event's name line
      text << '#' + event.name + "\r\n"
      
      # Add the comment line if there's a comment
      unless event.comment.blank?
        text << '/* ' + event.comment + " */\r\n"
      end
      
      # Add frequency if it exists
      unless event.frequency.blank?
        text << '@frequency "' + event.frequency + "\"\r\n"
      end
      
      # Add situation if it exists
      unless event.situation.blank?
        text << '@situation "' + event.situation + "\"\r\n"
      end
      
      # Add ambient if it exists
      unless event.ambient.blank?
        text << '@ambient "' + event.ambient + "\"\r\n"
      end
      
      # Add filter lines if there are any
      event.chosen_filters.each do |chosen_filter|
        text << '@f "' + chosen_filter.filter.name + "\"\r\n"
      end
      
      # Add the character line if it exists
      if (event.character_tool.tool)
        text << '@character = ' + view_context.toolstring(event.character_tool) + "\r\n"
      end
      
      # Add the location line if it exists
      if (event.location_tool.tool)
        text << '@location = ' + view_context.toolstring(event.location_tool) + "\r\n"
      end
      
      # Add the trigger line if it exists
      if (event.trigger_tool.tool)
        text << '@trigger = ' + view_context.toolstring(event.location_tool) + "\r\n"
      end
      
      # Add the event prerequisite probability line if there are any
      if event.parent
        text << '@p { event["' + event.parent.name + '"].outcome = 0 '
        if event.chosen_outcomes.any?
          chosenoutcomes = []
          event.chosen_outcomes.each do |outcome|
            if event.parent.id == outcome.content_outcome.root.event.id
              chosenoutcomes << outcome.content_outcome
            end
          end
          endoutcomes = []
          event.parent.content_root.descendants.where(:type => 'ContentEffect').each do |effect|
            if effect.tool1 && effect.tool1.tool.name == 'end'
              endoutcomes << effect.parent
            end
          end
          (endoutcomes - chosenoutcomes).each do |outcome|
            text << 'OR event["' + event.parent.name + '"].outcome = ' + outcome.id.to_s + ' '
          end
        end
        text << "} = 0\r\n"
      end
      
      # Add the secondary event link lines if there are any
      event.secondary_prereqs.each do |secondary_prereq|
        if secondary_prereq.prereq_id
          text << '@p {'
          # If there are chosen outcomes only mark them
          if secondary_prereq.secondary_chosen_outcomes.any?
            first = true
            secondary_prereq.secondary_chosen_outcomes.each do |secondary_chosen_outcome|
              if first
                text << ' event["' + secondary_prereq.prereq.name + '"].outcome = ' + secondary_chosen_outcome.content_outcome.id.to_s
                first = false
              else
                text << ' OR event["' + secondary_prereq.prereq.name + '"].outcome = ' + secondary_chosen_outcome.content_outcome.id.to_s
              end
            end
          # If there aren't any chosen outcomes, mark all end outcomes
          else
            text << ' event["' + secondary_prereq.prereq.name + '"].outcome != 0'
          end
          text << " } = " + secondary_prereq.p + "\r\n"
        end
      end

      # Add the probability lines if there are any
      event.probabilities.each do |probability|
        text << '@p'
        if probability.equality1 != 'range'
          if (!probability.condition.blank?)
            text << ' { ' + view_context.toolstring(probability.tool1)
            unless probability.tool1.tool && probability.tool1.tool.booleanreturn
              if !probability.equality1.nil?
                text << ' ' + probability.equality1
              end
              if !probability.value1.nil?
                text << ' ' + probability.value1
              end
            end
            if (!probability.andor.blank?)
              text << ' ' + probability.andor + ' ' + view_context.toolstring(probability.tool2)
              unless probability.tool2.tool && probability.tool2.tool.booleanreturn
                if !probability.equality2.nil?
                  text << ' ' + probability.equality2
                end
                if !probability.value2.nil?
                  text << ' ' + probability.value2
                end
              end
            end
            text << ' }'
          end
        # Handle range value in equality1 differently
        else
          text << ' { ' + view_context.toolstring(probability.tool1) + ' > ' 
          if !probability.value1.nil?
            text << probability.value1 + ' AND ' + view_context.toolstring(probability.tool1) + ' <= '
          end
          if !probability.rangevalue.nil?
            text << probability.rangevalue
          end
          text << ' }'
        end 
        text << ' = ' + probability.p + "\r\n"
      end
      
      # Add the content lines if there are any
      Content.sort_by_ancestry(event.content_root.subtree).each do |content|
        if content.type == 'ContentText'
          text << '@t {o = '
          if content.parent.type == 'ContentRoot'
            text << '0'
          else
            text << content.parent.id.to_s
          end
          unless content.condition.blank?
            if content.equality1 != 'range'
              text << ' AND ' + view_context.toolstring(content.tool1)
              unless content.tool1.tool && content.tool1.tool.booleanreturn
                unless content.equality1.nil?
                  text << ' ' + content.equality1
                end
                unless content.value1.nil?
                  text << ' ' + content.value1
                end
              end
              unless content.andor.blank?
                text << ' ' + content.andor + ' ' + view_context.toolstring(content.tool2)
                unless content.tool2.tool && content.tool2.tool.booleanreturn
                  unless content.equality2.nil?
                    text << ' ' + content.equality2
                  end
                  unless content.value2.nil?
                    text << ' ' + content.value2
                  end
                end
              end
            else
              text << ' AND ' + view_context.toolstring(content.tool1) + ' > '
              unless content.value1.nil?
                text << content.value1
              end
              text << ' AND ' + view_context.toolstring(content.tool1) + ' <= '
              unless content.rangevalue.nil?
                text << content.rangevalue
              end
            end
          end
          unless content.text.nil?
            text << '} "' + content.text + "\"\r\n"
          end
        elsif content.type == 'ContentChoice'
          text << '@c {o = '
          if content.parent.type == 'ContentRoot'
            text << '0'
          else
            text << content.parent.id.to_s
          end
          unless content.condition.blank?
            if content.equality1 != 'range'
              text << ' AND ' + view_context.toolstring(content.tool1)
              unless content.tool1.tool && content.tool1.tool.booleanreturn
                unless content.equality1.nil?
                  text << ' ' + content.equality1
                end
                unless content.value1.nil?
                  text << ' ' + content.value1
                end
              end
              unless content.andor.blank?
                text << ' ' + content.andor + ' ' + view_context.toolstring(content.tool2)
                unless content.tool2.tool && content.tool2.tool.booleanreturn
                  unless content.equality2.nil?
                    text << ' ' + content.equality2
                  end
                  unless content.value2.nil?
                    text << ' ' + content.value2
                  end
                end
              end
            else
              text << ' AND ' + view_context.toolstring(content.tool1) + ' > '
              unless content.value1.nil?
                text << content.value1
              end
              text << ' AND ' + view_context.toolstring(content.tool1) + ' <= '
              unless content.rangevalue.nil?
                text << content.rangevalue
              end
            end
          end
          text << '} "'
          unless content.text.nil?
            text << content.text
          end
          text << "\" = " + content.id.to_s + "\r\n"
        elsif content.type == 'ContentOutcome'
          text << '@o {c = ' + content.parent.id.to_s
          unless content.condition.blank?
            if content.equality1 != 'range'
              text << ' AND ' + view_context.toolstring(content.tool1)
              unless content.tool1.tool && content.tool1.tool.booleanreturn
                unless content.equality1.nil?
                  text << ' ' + content.equality1
                end
                unless content.value1.nil?
                  text << ' ' + content.value1
                end
              end
              unless content.andor.blank?
                text << ' ' + content.andor + ' ' + view_context.toolstring(content.tool2)
                unless content.tool2.tool && content.tool2.tool.booleanreturn
                  unless content.equality2.nil?
                    text << ' ' + content.equality2
                  end
                  unless content.value2.nil?
                    text << ' ' + content.value2
                  end
                end
              end
            else
              text << ' AND ' + view_context.toolstring(content.tool1) + ' > '
              unless content.value1.nil?
                text << content.value1
              end
              text << ' AND ' + view_context.toolstring(content.tool1) + ' <= '
              unless content.rangevalue.nil?
                text << content.rangevalue
              end
            end
          end
          text << '} = ' + content.id.to_s
          content.children.where(:type => 'ContentEffect').each do |effect|
            text << ' $=' + view_context.toolstring(effect.tool1)
          end
          text << "\r\n"
        end
      end
      
      # Add captain advice lines if there are any
      AdviceContent.sort_by_ancestry(event.captain_root.subtree).each do |advice|
        if advice.type != "AdviceContentRoot" && advice.children.empty?
          temptext = ""
          if advice.tool.tool
            if advice.tool.tool.booleanreturn
              temptext = view_context.toolstring(advice.tool)
            elsif !advice.equality.blank? && !advice.value.blank?
              temptext = view_context.toolstring(advice.tool) + " " + advice.equality + " " + advice.value
            end
          end
          par = advice.parent
          while par.type != "AdviceContentRoot"
            if par.tool.tool
              if par.tool.tool.booleanreturn
                if !temptext.blank?
                  temptext = " AND " + temptext
                end
                temptext = view_context.toolstring(par.tool) + temptext
              elsif !par.equality.blank? && !par.value.blank?
                if !temptext.blank?
                  temptext = " AND " + temptext
                end
                temptext = view_context.toolstring(par.tool) + " " + par.equality + " " + par.value + temptext
              end
            end
            par = par.parent
          end
          if !temptext.blank?
            temptext = " { " + temptext + " }"
          end
          if !advice.text.blank?
            text << "@a captain" + temptext + " \"" + advice.text + "\""
          else
            text << "@a captain" + temptext + " \"\""
          end
          if !advice.content_choice.blank?
            text << " = " + advice.content_choice.id.to_s
          end
          text << "\r\n"
        end
      end
      
      # Add navigator advice lines if there are any
      AdviceContent.sort_by_ancestry(event.navigator_root.subtree).each do |advice|
        if advice.type != "AdviceContentRoot" && advice.children.empty?
          temptext = ""
          if advice.tool.tool
            if advice.tool.tool.booleanreturn
              temptext = view_context.toolstring(advice.tool)
            elsif !advice.equality.blank? && !advice.value.blank?
              temptext = view_context.toolstring(advice.tool) + " " + advice.equality + " " + advice.value
            end
          end
          par = advice.parent
          while par.type != "AdviceContentRoot"
            if par.tool.tool
              if par.tool.tool.booleanreturn
                if !temptext.blank?
                  temptext = " AND " + temptext
                end
                temptext = view_context.toolstring(par.tool) + temptext
              elsif !par.equality.blank? && !par.value.blank?
                if !temptext.blank?
                  temptext = " AND " + temptext
                end
                temptext = view_context.toolstring(par.tool) + " " + par.equality + " " + par.value + temptext
              end
            end
            par = par.parent
          end
          if !temptext.blank?
            temptext = " { " + temptext + " }"
          end
          if !advice.text.blank?
            text << "@a navigator" + temptext + " \"" + advice.text + "\""
          else
            text << "@a navigator" + temptext + " \"\""
          end
          if !advice.content_choice.blank?
            text << " = " + advice.content_choice.id.to_s
          end
          text << "\r\n"
        end
      end
      
      # Add engineer advice lines if there are any
      AdviceContent.sort_by_ancestry(event.engineer_root.subtree).each do |advice|
        if advice.type != "AdviceContentRoot" && advice.children.empty?
          temptext = ""
          if advice.tool.tool
            if advice.tool.tool.booleanreturn
              temptext = view_context.toolstring(advice.tool)
            elsif !advice.equality.blank? && !advice.value.blank?
              temptext = view_context.toolstring(advice.tool) + " " + advice.equality + " " + advice.value
            end
          end
          par = advice.parent
          while par.type != "AdviceContentRoot"
            if par.tool.tool
              if par.tool.tool.booleanreturn
                if !temptext.blank?
                  temptext = " AND " + temptext
                end
                temptext = view_context.toolstring(par.tool) + temptext
              elsif !par.equality.blank? && !par.value.blank?
                if !temptext.blank?
                  temptext = " AND " + temptext
                end
                temptext = view_context.toolstring(par.tool) + " " + par.equality + " " + par.value + temptext
              end
            end
            par = par.parent
          end
          if !temptext.blank?
            temptext = " { " + temptext + " }"
          end
          if !advice.text.blank?
            text << "@a engineer" + temptext + " \"" + advice.text + "\""
          else
            text << "@a engineer" + temptext + " \"\""
          end
          if !advice.content_choice.blank?
            text << " = " + advice.content_choice.id.to_s
          end
          text << "\r\n"
        end
      end
      
      # Add security advice lines if there are any
      AdviceContent.sort_by_ancestry(event.security_root.subtree).each do |advice|
        if advice.type != "AdviceContentRoot" && advice.children.empty?
          temptext = ""
          if advice.tool.tool
            if advice.tool.tool.booleanreturn
              temptext = view_context.toolstring(advice.tool)
            elsif !advice.equality.blank? && !advice.value.blank?
              temptext = view_context.toolstring(advice.tool) + " " + advice.equality + " " + advice.value
            end
          end
          par = advice.parent
          while par.type != "AdviceContentRoot"
            if par.tool.tool
              if par.tool.tool.booleanreturn
                if !temptext.blank?
                  temptext = " AND " + temptext
                end
                temptext = view_context.toolstring(par.tool) + temptext
              elsif !par.equality.blank? && !par.value.blank?
                if !temptext.blank?
                  temptext = " AND " + temptext
                end
                temptext = view_context.toolstring(par.tool) + " " + par.equality + " " + par.value + temptext
              end
            end
            par = par.parent
          end
          if !temptext.blank?
            temptext = " { " + temptext + " }"
          end
          if !advice.text.blank?
            text << "@a security" + temptext + " \"" + advice.text + "\""
          else
            text << "@a security" + temptext + " \"\""
          end
          if !advice.content_choice.blank?
            text << " = " + advice.content_choice.id.to_s
          end
          text << "\r\n"
        end
      end
      
      # Add quartermaster advice lines if there are any
      AdviceContent.sort_by_ancestry(event.quartermaster_root.subtree).each do |advice|
        if advice.type != "AdviceContentRoot" && advice.children.empty?
          temptext = ""
          if advice.tool.tool
            if advice.tool.tool.booleanreturn
              temptext = view_context.toolstring(advice.tool)
            elsif !advice.equality.blank? && !advice.value.blank?
              temptext = view_context.toolstring(advice.tool) + " " + advice.equality + " " + advice.value
            end
          end
          par = advice.parent
          while par.type != "AdviceContentRoot"
            if par.tool.tool
              if par.tool.tool.booleanreturn
                if !temptext.blank?
                  temptext = " AND " + temptext
                end
                temptext = view_context.toolstring(par.tool) + temptext
              elsif !par.equality.blank? && !par.value.blank?
                if !temptext.blank?
                  temptext = " AND " + temptext
                end
                temptext = view_context.toolstring(par.tool) + " " + par.equality + " " + par.value + temptext
              end
            end
            par = par.parent
          end
          if !temptext.blank?
            temptext = " { " + temptext + " }"
          end
          if !advice.text.blank?
            text << "@a quartermaster" + temptext + " \"" + advice.text + "\""
          else
            text << "@a quartermaster" + temptext + " \"\""
          end
          if !advice.content_choice.blank?
            text << " = " + advice.content_choice.id.to_s
          end
          text << "\r\n"
        end
      end
      
      # Add psycher advice lines if there are any
      AdviceContent.sort_by_ancestry(event.psycher_root.subtree).each do |advice|
        if advice.type != "AdviceContentRoot" && advice.children.empty?
          temptext = ""
          if advice.tool.tool
            if advice.tool.tool.booleanreturn
              temptext = view_context.toolstring(advice.tool)
            elsif !advice.equality.blank? && !advice.value.blank?
              temptext = view_context.toolstring(advice.tool) + " " + advice.equality + " " + advice.value
            end
          end
          par = advice.parent
          while par.type != "AdviceContentRoot"
            if par.tool.tool
              if par.tool.tool.booleanreturn
                if !temptext.blank?
                  temptext = " AND " + temptext
                end
                temptext = view_context.toolstring(par.tool) + temptext
              elsif !par.equality.blank? && !par.value.blank?
                if !temptext.blank?
                  temptext = " AND " + temptext
                end
                temptext = view_context.toolstring(par.tool) + " " + par.equality + " " + par.value + temptext
              end
            end
            par = par.parent
          end
          if !temptext.blank?
            temptext = " { " + temptext + " }"
          end
          if !advice.text.blank?
            text << "@a psycher" + temptext + " \"" + advice.text + "\""
          else
            text << "@a psycher" + temptext + " \"\""
          end
          if !advice.content_choice.blank?
            text << " = " + advice.content_choice.id.to_s
          end
          text << "\r\n"
        end
      end
      
      # Add priest advice lines if there are any
      AdviceContent.sort_by_ancestry(event.priest_root.subtree).each do |advice|
        if advice.type != "AdviceContentRoot" && advice.children.empty?
          temptext = ""
          if advice.tool.tool
            if advice.tool.tool.booleanreturn
              temptext = view_context.toolstring(advice.tool)
            elsif !advice.equality.blank? && !advice.value.blank?
              temptext = view_context.toolstring(advice.tool) + " " + advice.equality + " " + advice.value
            end
          end
          par = advice.parent
          while par.type != "AdviceContentRoot"
            if par.tool.tool
              if par.tool.tool.booleanreturn
                if !temptext.blank?
                  temptext = " AND " + temptext
                end
                temptext = view_context.toolstring(par.tool) + temptext
              elsif !par.equality.blank? && !par.value.blank?
                if !temptext.blank?
                  temptext = " AND " + temptext
                end
                temptext = view_context.toolstring(par.tool) + " " + par.equality + " " + par.value + temptext
              end
            end
            par = par.parent
          end
          if !temptext.blank?
            temptext = " { " + temptext + " }"
          end
          if !advice.text.blank?
            text << "@a priest" + temptext + " \"" + advice.text + "\""
          else
            text << "@a priest" + temptext + " \"\""
          end
          if !advice.content_choice.blank?
            text << " = " + advice.content_choice.id.to_s
          end
          text << "\r\n"
        end
      end
      
      # Add an extra empty line when the event ends
      text << "\r\n"
    end

    send_data text,  :filename => "events.txt"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:name, :comment, :frequency, :situation, :ambient, :character_skill_id, :character_tool_id, :location_tool_id, :filter_id, :chosen_outcome_id, :parent_id,
      :character_tool_attributes => [:id, :tool_id, :pre_tool_id, :chosen_parameters_attributes => [:id, :chosen_tool_id, :parameter_value_id, :custom_value, :parameter_id]],
      :location_tool_attributes => [:id, :tool_id, :pre_tool_id, :chosen_parameters_attributes => [:id, :chosen_tool_id, :parameter_value_id, :custom_value, :parameter_id]],
      :trigger_tool_attributes => [:id, :tool_id, :pre_tool_id, :chosen_parameters_attributes => [:id, :chosen_tool_id, :parameter_value_id, :custom_value, :parameter_id]])
    end
end
