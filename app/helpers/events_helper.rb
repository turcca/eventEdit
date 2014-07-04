module EventsHelper
  
  def flipequality(equality)
    flippedequality = ''
    if equality == '='
      flippedequality = 'NOT'
    elsif equality == '<'
      flippedequality = '>='
    elsif equality == '>'
      flippedequality = '<='
    elsif equality == '<='
      flippedequality = '>'
    elsif equality == '>='
      flippedequality = '<'
    else
      flippedequality = '='
    end
    flippedequality
  end
  
end
