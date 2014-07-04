class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validate :cant_remove_admin_rights_from_last_admin       
  before_update :revert_approved_if_changed_to_false, :if => Proc.new { |u| !u.approved && u.approved_changed? }
  before_update :revert_admin_true_if_approved_false
  
  def active_for_authentication? 
    super && approved? 
  end 

  def inactive_message 
    if !approved? 
      :not_approved 
    else 
      super # Use whatever other message 
    end 
  end
  
  def self.send_reset_password_instructions(attributes={})
    recoverable = find_or_initialize_with_errors(reset_password_keys, attributes, :not_found)
    if !recoverable.approved?
      recoverable.errors[:base] << I18n.t("devise.failure.not_approved")
    elsif recoverable.persisted?
      recoverable.send_reset_password_instructions
    end
    recoverable
  end
  
  private
  
  def cant_remove_admin_rights_from_last_admin
    if !self.admin && self.admin_changed?
      if User.where("admin = ? AND id != ?", true, self.id).empty?
        errors.add(:admin, " rights cannot be removed from the last admin")
      end
    end
  end
  
  def revert_approved_if_changed_to_false
    self.approved = self.approved_was
  end
  
  def revert_admin_true_if_approved_false
    if !self.approved && self.admin
      self.admin = false
    end
  end
  
end
