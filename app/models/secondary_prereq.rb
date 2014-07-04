class SecondaryPrereq < ActiveRecord::Base
  belongs_to :event
  belongs_to :prereq, :class_name => 'Event'
  has_many :secondary_chosen_outcomes, :dependent => :destroy
  
  accepts_nested_attributes_for :secondary_chosen_outcomes, :allow_destroy => true
  
  attr_accessor :secondary_chosen_outcome_id
  
  before_save :mark_secondary_chosen_outcomes_for_removal
  
  def get_available_secondary_outcomes
    outcomes = []
    unless self.prereq_id.blank?
      self.prereq.content_root.descendants.where(:type => 'ContentEffect').each do |effect|
        if effect.tool1 && effect.tool1.tool.name == 'end'
          outcomes << effect.parent
        end
      end
      remove_outcomes = []
      self.event.secondary_prereqs.each do |secondary_prereq|
        secondary_prereq.secondary_chosen_outcomes.each do |secondary_chosen_outcome|
          remove_outcomes << secondary_chosen_outcome.content_outcome
        end
      end
      if self.prereq == self.event.parent && self.event.chosen_outcomes.any?
        endoutcomes = []
        self.event.parent.content_root.descendants.where(:type => 'ContentEffect').each do |effect|
          if effect.tool1 && effect.tool1.tool.name == 'end'
            endoutcomes << effect.parent
          end
        end
        chosenoutcomes = []
        ChosenOutcome.where(:event_id => event.id).each do |outcome|
          if event.parent.id == outcome.content_outcome.root.event.id
            chosenoutcomes << outcome.content_outcome
          end
        end
        remove_outcomes += (endoutcomes - chosenoutcomes)
      end
      outcomes = outcomes - remove_outcomes
    end
    return outcomes
  end
  
  def mark_secondary_chosen_outcomes_for_removal
    if self.prereq_id.blank?
      puts 'AAAAAAAAAAAAAAAAAAAAAAAARGH 2'
      self.secondary_chosen_outcomes.each do |secondary_chosen_outcome|
        secondary_chosen_outcome.mark_for_destruction
        puts 'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAARGH 3 ' + secondary_chosen_outcome.marked_for_destruction?.to_s
      end
    else
      self.secondary_chosen_outcomes.each do |secondary_chosen_outcome|
        secondary_chosen_outcome.mark_for_destruction if secondary_chosen_outcome.content_outcome_id.blank?
        secondary_chosen_outcome.mark_for_destruction if secondary_chosen_outcome.content_outcome.root.event_id != secondary_chosen_outcome.secondary_prereq.prereq_id
      end
    end
  end
  
end
