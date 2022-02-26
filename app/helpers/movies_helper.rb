module MoviesHelper
  # Checks if a number is odd:
  def oddness(count)
    count.odd? ?  "odd" :  "even"
  end
  
  
  
  def selected_rating?(rating)
    selected_ratings = session[:ratings]
    return true if selected_ratings.nil?
    selected_ratings.include? rating
  end
  
  def hilite(column)
    if(session[:sort].to_s == column)
      return 'hilite'
    else
      return nil
    end
  end
end
