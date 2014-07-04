class ContentChoice < Content
  include ActionView::Helpers::TextHelper
  
  has_one :advice_content_advice
  
  def sibling_choices_after_this
    siblings.where(type: 'ContentChoice').where("id > ?", id)
  end
  
  def sibling_choices_before_this
    siblings.where(type: 'ContentChoice').where("id < ?", id)
  end
  
  def text_for_selecting_choice
    return truncate(text, :length => 20)
  end
  
end