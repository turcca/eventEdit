class Event < ActiveRecord::Base
  default_scope -> { order('name') }
  
  has_ancestry :orphan_strategy => :rootify
  
  FREQUENCY = ['Rare', 'Default', 'Elevated', 'Probable']
  SITUATION = ['Quiet', 'Default', 'Alert', 'Panic']
  AMBIENT = ['ActionBase', 'DefaultBridge', 'EchoRoom', 'EngineRoom', 'Fracture', 'QuietEerie', 'QuietHum']
  
  validates :name, :allow_blank => true, :uniqueness => true
  validate :check_ancestry_for_errors
  
  has_many :probabilities, :dependent => :destroy
  has_many :chosen_filters, :inverse_of => :event, :dependent => :destroy
  has_many :filters, through: :chosen_filters
  has_many :chosen_outcomes, :dependent => :destroy
  has_many :secondary_prereqs, :inverse_of => :event, :inverse_of => :event, :dependent => :destroy
  has_many :secondary_descendants, :class_name => 'SecondaryPrereq', :foreign_key => 'prereq_id', :inverse_of => :prereq, :dependent => :destroy
  has_many :secondary_prereq_events, :through => :secondary_prereqs, :source => :event
  has_one :content_root, :dependent => :destroy
  has_one :captain_root, :class_name => 'AdviceContentRoot', :foreign_key => 'captain_id', :dependent => :destroy
  has_one :navigator_root, :class_name => 'AdviceContentRoot', :foreign_key => 'navigator_id', :dependent => :destroy
  has_one :engineer_root, :class_name => 'AdviceContentRoot', :foreign_key => 'engineer_id', :dependent => :destroy
  has_one :quartermaster_root, :class_name => 'AdviceContentRoot', :foreign_key => 'quartermaster_id', :dependent => :destroy
  has_one :security_root, :class_name => 'AdviceContentRoot', :foreign_key => 'security_id', :dependent => :destroy
  has_one :priest_root, :class_name => 'AdviceContentRoot', :foreign_key => 'priest_id', :dependent => :destroy
  has_one :psycher_root, :class_name => 'AdviceContentRoot', :foreign_key => 'psycher_id', :dependent => :destroy
  belongs_to :character_tool, :class_name => 'ChosenTool', :dependent => :destroy
  belongs_to :location_tool, :class_name => 'ChosenTool', :dependent => :destroy
  belongs_to :trigger_tool, :class_name => 'ChosenTool', :dependent => :destroy
  
  accepts_nested_attributes_for :character_tool, :allow_destroy => true
  accepts_nested_attributes_for :location_tool, :allow_destroy => true
  accepts_nested_attributes_for :trigger_tool, :allow_destroy => true
  accepts_nested_attributes_for :chosen_filters, :allow_destroy => true
  accepts_nested_attributes_for :chosen_outcomes, :allow_destroy => true
  
  before_save { build_content_root unless content_root }
  before_save { build_captain_root unless captain_root }
  before_save { build_navigator_root unless navigator_root }
  before_save { build_engineer_root unless engineer_root }
  before_save { build_quartermaster_root unless quartermaster_root }
  before_save { build_security_root unless security_root }
  before_save { build_priest_root unless priest_root }
  before_save { build_psycher_root unless psycher_root }
  before_save :mark_filters_for_removal
  before_save :update_filter_color
  before_save :mark_chosen_outcomes_for_removal
  #before_save :create_chosen_outcomes_from_secondary_prereqs
  
  attr_accessor :filter_id
  attr_accessor :chosen_outcome_id

  def get_choices_for_advice
    advice = []
    self.content_root.descendants.where(:type => 'ContentChoice').each do |choice|
      if choice.text && !choice.text.empty? && choice.parent.type == 'ContentRoot'
        advice << choice
      end
    end
    return advice
  end

  def get_available_outcomes
    outcomes = []
    unless self.parent.nil?
      self.parent.content_root.descendants.where(:type => 'ContentEffect').each do |effect|
        if effect.tool1 && effect.tool1.tool.name == 'end'
          outcomes << effect.parent
        end
      end
      remove_outcomes = []
      ChosenOutcome.where('event_id = ?', self.id).each do |chosen_outcome|
        remove_outcomes << chosen_outcome.content_outcome
      end
      #self.secondary_prereqs.each do |secondary_prereq|
      #  secondary_prereq.secondary_chosen_outcomes.each do |secondary_chosen_outcome|
      #    remove_outcomes << secondary_chosen_outcome.content_outcome
      #  end
      #end
      outcomes = outcomes - remove_outcomes
    end
    return outcomes
  end
  
  def get_available_filters
    filters = Filter.all
    remove_filters = []
    self.chosen_filters.each do |chosen_filter|
      filters.each do |filter|
        if filter.id == chosen_filter.filter_id
          remove_filters << filter
        end
      end
    end
    filters = filters - remove_filters
    return filters
  end

  private
  
  def mark_filters_for_removal
    chosen_filters.each do |filter|
      filter.mark_for_destruction if filter.filter_id.blank?
    end
  end
  
  def update_filter_color
    if self.chosen_filters.empty?
      self.filtercolor = "#FFFFFF"
      self.colorfiltername = ""
    else
      self.filtercolor = chosen_filters.first.filter.color
      self.colorfiltername = chosen_filters.first.filter.name
    end
  end
  
  def mark_chosen_outcomes_for_removal
    if self.parent.nil?
      chosen_outcomes.each do |chosen_outcome|
        chosen_outcome.mark_for_destruction
      end
    else
      chosen_outcomes.each do |chosen_outcome|
        chosen_outcome.mark_for_destruction if chosen_outcome.content_outcome_id.blank?
        chosen_outcome.mark_for_destruction if chosen_outcome.content_outcome.root.event_id != self.parent_id
      end
    end
  end
  
  def check_ancestry_for_errors
    if self.parent && self.parent.changed?
      begin
        Event.check_ancestry_integrity!
      rescue Ancestry::AncestryIntegrityException
        errors.add(:parent_id, " for the parent event causes a loop in the event tree.")
      end
    end
  end
  
  #def create_chosen_outcomes_from_secondary_prereqs
  #  secondary_prereqs.each do |secondary_prereq|
  #    if self.parent && secondary_prereq.prereq && secondary_prereq.prereq == self.parent
  #      if secondary_prereq.secondary_chosen_outcomes.any?
  #        secondary_prereq.secondary_chosen_outcomes.each do |secondary_chosen_outcome|
  #          if !self.chosen_outcomes.include?(secondary_chosen_outcome.content_outcome)
  #            chosen_outcomes << ChosenOutcome.new(:event_id => self.id, :content_outcome_id => secondary_chosen_outcome.content_outcome_id)
  #          end
  #        end
  #      else
  #        
  #      end
  #    end
  #  end
  #end
  
end
