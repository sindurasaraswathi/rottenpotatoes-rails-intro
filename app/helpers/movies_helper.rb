module MoviesHelper
  # Checks if a number is odd:
  def oddness(count)
    count.odd? ?  "odd" :  "even"
  end
  
  
  
  def rating_selected(rating)
    ratings_selected = session[:ratings]
    if ratings_selected.nil?
      return true 
    end
    ratings_selected.include? rating
  end
  
  def style(column)
    sort_selected = session[:sort].to_s
    if(column == sort_selected)
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
