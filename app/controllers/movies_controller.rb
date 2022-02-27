class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
  
      @all_ratings = Movie.uniq.pluck(:rating)
      @sorting = params[:sort]
      @rate = params[:ratings]
      @given_ratings = @all_ratings 
      
      if @rate
        @given_ratings =  @rate.keys 
      end
      
      if !@sorting
        @movies = Movie.where(rating: @given_ratings)
      else
        @movies = Movie.where(rating: @given_ratings).order(@sorting)
      end
     #part 3
     if @sorting
      session[:sort] = params[:sort] 
     end
     
     if @rate
      session[:ratings] = @rate
     end
      
      if (session[:ratings] && !@rate)
        flash.keep
        return redirect_to movies_path(ratings: session[:ratings], sort: @sorting)
        
      elsif (!@sorting && session[:sort])
        flash.keep
        return redirect_to movies_path(sort: session[:sort], ratings: @rate)
      
      elsif (!@sorting&& !@rate) && (session[:sort] && session[:ratings]) 
        flash.keep
        return redirect_to movies_path(sort: session[:sort], ratings: session[:ratings])
        
      end

  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

  private
  # Making "internal" methods private is not required, but is a common practice.
  # This helps make clear which methods respond to requests, and which ones do not.
  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end
end
