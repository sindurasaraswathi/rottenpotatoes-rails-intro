class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
  
      @all_ratings = Movie.uniq.pluck(:rating)
      @sorting = params[:sort]
      @given_ratings = @all_ratings 
      
      if params[:ratings]
        @given_ratings =  params[:ratings].keys 
      end
      
      if @sorting
        @movies = Movie.where(rating: @given_ratings).order(@sorting)
      else
        @movies = Movie.where(rating: @given_ratings)
      end
     #part 3
     if @sorting
      session[:sort] = params[:sort] 
     end
     
     if params[:ratings]
      session[:ratings] = params[:ratings]
     end
      
      if (session[:ratings] && !params[:ratings])
        flash.keep
        return redirect_to movies_path(sort: params[:sort], ratings: session[:ratings])
        
      elsif (!params[:sort] && !params[:ratings]) && (session[:sort] && session[:ratings])
        flash.keep
        return redirect_to movies_path(sort: session[:sort], ratings: session[:ratings])
        
      elsif (session[:sort] && !params[:sort])
        flash.keep
        return redirect_to movies_path(sort: session[:sort], ratings: params[:ratings])
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
