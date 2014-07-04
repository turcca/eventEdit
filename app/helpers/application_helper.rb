module ApplicationHelper
  
  def self.toolstring(tool)
    if (tool.nil?)
      return ''
    end
    str = ''
    if (!tool.pre_tool.blank?)
      str << tool.pre_tool.name + '.'
    end
    if (!tool.tool.blank?)
      str << tool.tool.name
      if (tool.tool.tooltype == 'method')
        str << '('
        first = true
        tool.chosen_parameters.each do |param|
          if first
            first = false
          else
            str << ', '
          end
          if !param.custom_value.blank?
            if param.parameter.parameter_type.needs_quotation
              str << '"' + param.custom_value + '"'
            else
              str << param.custom_value
            end
          else
            if param.parameter.parameter_type.needs_quotation
              str << '"' + param.parameter_value.name + '"'
            else
              str << param.parameter_value.name
            end
          end
        end
        str << ')'
      end
    end
    return str
  end
  
  def toolstring(tool)
    return ApplicationHelper.toolstring(tool)
  end
  
  def self.toolarray_for_selecting(place, chosen_tool, tool_or_pretool, event)
    if place == 'probability'
      if tool_or_pretool == 'pretool'
        return_array = Tool.where("probability = ? AND id not in (?)", true, PreToolAssociation.all.pluck("tool_id")).collect{|o| [ o.name, o.id, :title => o.tooltip ]}
      else
        if chosen_tool.nil? || chosen_tool.pre_tool_id.blank?
          return_array = Tool.where("probability = ? AND id not in (?)", true, PreToolAssociation.all.pluck("tool_id")).collect{|o| [ o.name, o.id, :title => o.tooltip ]}
        else
          return_array = Tool.where(:id => PreToolAssociation.where("pre_tool_id = ?", chosen_tool.pre_tool_id).pluck("tool_id"), :probability => true).collect{|o| [ o.name, o.id, :title => o.tooltip ]}
        end
      end
    elsif place == 'content_text' || place == 'content_choice' || place == 'content_outcome'
      if tool_or_pretool == 'pretool'
        return_array = Tool.where("content_condition = ? AND id not in (?)", true, PreToolAssociation.all.pluck("tool_id")).collect{|o| [ o.name, o.id, :title => o.tooltip ]}
      else
        if chosen_tool.nil? || chosen_tool.pre_tool_id.blank?
          return_array = Tool.where("content_condition = ? AND id not in (?)", true, PreToolAssociation.all.pluck("tool_id")).collect{|o| [ o.name, o.id, :title => o.tooltip ]}
        else
          return_array = Tool.where(:id => PreToolAssociation.where("pre_tool_id = ?", chosen_tool.pre_tool_id).pluck("tool_id"), :content_condition => true).collect{|o| [ o.name, o.id, :title => o.tooltip ]}
        end
      end
    elsif place == 'content_effect'
      if tool_or_pretool == 'pretool'
        return_array = Tool.where("content_effect = ? AND id not in (?)", true, PreToolAssociation.all.pluck("tool_id")).collect{|o| [ o.name, o.id, :title => o.tooltip ]}
      else
        if chosen_tool.nil? || chosen_tool.pre_tool_id.blank?
          return_array = Tool.where("content_effect = ? AND id not in (?)", true, PreToolAssociation.all.pluck("tool_id")).collect{|o| [ o.name, o.id, :title => o.tooltip ]}
        else
          return_array = Tool.where(:id => PreToolAssociation.where("pre_tool_id = ?", chosen_tool.pre_tool_id).pluck("tool_id"), :content_effect => true).collect{|o| [ o.name, o.id, :title => o.tooltip ]}
        end
      end
    elsif place == 'character'
      if tool_or_pretool == 'pretool'
        return_array = Tool.where("character = ? AND id not in (?)", true, PreToolAssociation.all.pluck("tool_id")).collect{|o| [ o.name, o.id, :title => o.tooltip ]}
      else
        if chosen_tool.nil? || chosen_tool.pre_tool_id.blank?
          return_array = Tool.where("character = ? AND id not in (?)", true, PreToolAssociation.all.pluck("tool_id")).collect{|o| [ o.name, o.id, :title => o.tooltip ]}
        else
          return_array = Tool.where(:id => PreToolAssociation.where("pre_tool_id = ?", chosen_tool.pre_tool_id).pluck("tool_id"), :character => true).collect{|o| [ o.name, o.id, :title => o.tooltip ]}
        end
      end
    elsif place == 'trigger'
      if tool_or_pretool == 'pretool'
        return_array = Tool.where("trigger = ? AND id not in (?)", true, PreToolAssociation.all.pluck("tool_id")).collect{|o| [ o.name, o.id, :title => o.tooltip ]}
      else
        if chosen_tool.nil? || chosen_tool.pre_tool_id.blank?
          return_array = Tool.where("trigger = ? AND id not in (?)", true, PreToolAssociation.all.pluck("tool_id")).collect{|o| [ o.name, o.id, :title => o.tooltip ]}
        else
          return_array = Tool.where(:id => PreToolAssociation.where("pre_tool_id = ?", chosen_tool.pre_tool_id).pluck("tool_id"), :trigger => true).collect{|o| [ o.name, o.id, :title => o.tooltip ]}
        end
      end
    elsif place == 'location'
      if tool_or_pretool == 'pretool'
        return_array = Tool.where("location = ? AND id not in (?)", true, PreToolAssociation.all.pluck("tool_id")).collect{|o| [ o.name, o.id, :title => o.tooltip ]}
      else
        if chosen_tool.nil? || chosen_tool.pre_tool_id.blank?
          return_array = Tool.where("location = ? AND id not in (?)", true, PreToolAssociation.all.pluck("tool_id")).collect{|o| [ o.name, o.id, :title => o.tooltip ]}
        else
          return_array = Tool.where(:id => PreToolAssociation.where("pre_tool_id = ?", chosen_tool.pre_tool_id).pluck("tool_id"), :location => true).collect{|o| [ o.name, o.id, :title => o.tooltip ]}
        end
      end
    elsif place == 'advice'
      if tool_or_pretool == 'pretool'
        return_array = Tool.where("advice = ? AND id not in (?)", true, PreToolAssociation.all.pluck("tool_id")).collect{|o| [ o.name, o.id, :title => o.tooltip ]}
      else
        if chosen_tool.nil? || chosen_tool.pre_tool_id.blank?
          return_array = Tool.where("advice = ? AND id not in (?)", true, PreToolAssociation.all.pluck("tool_id")).collect{|o| [ o.name, o.id, :title => o.tooltip ]}
        else
          return_array = Tool.where(:id => PreToolAssociation.where("pre_tool_id = ?", chosen_tool.pre_tool_id).pluck("tool_id"), :advice => true).collect{|o| [ o.name, o.id, :title => o.tooltip ]}
        end
      end
    end

    unless place == 'character' || place == 'trigger' || place == 'location'
      removables = []
      if event.character_tool.nil? || !event.character_tool.complete
        return_array.each do |option|
          if option[0] == 'character'
            removables << option
          end
        end
      end
      if event.location_tool.nil? || !event.location_tool.complete
        return_array.each do |option|
          if option[0] == 'location'
            removables << option
          end
        end
      end
      return_array = return_array - removables
    end
    
    return return_array
  end
  
  def toolarray_for_selecting(place, chosen_tool, tool_or_pretool, event)
    return ApplicationHelper.toolarray_for_selecting(place, chosen_tool, tool_or_pretool, event)
  end
  
end
