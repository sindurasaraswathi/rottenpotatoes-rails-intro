module MoviesHelper
  # Checks if a number is odd:
  def oddness(count)
    count.odd? ?  "odd" :  "even"
  end
  
  
  
  def selected_rating?(rating)
    selected_ratings = session[:ratings]
    if selected_ratings.nil?
      return true 
    end
    selected_ratings.include? rating
  end
  
  def hilite(column)
    
    if(session[:sort].to_s == column)
      if column == 'title'
        return 'hilite'
      elsif column == 'release_date'
        return 'p-3 mb-2 bg-warning text-dark'
      end
    else
      return nil
    end
  end
end
