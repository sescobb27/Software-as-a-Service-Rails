class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    if params[:ratings]
      @ratings = params[:ratings].keys
      Movie.ratings.each_pair do |rating,value|
        if @ratings.include? rating
          Movie.ratings()[rating] = true
        else
          Movie.ratings()[rating] = false
        end
      end
    end
    @ratings = Movie.ratings().select { |rating,status| if status ; rating ; end }.keys unless @ratings
    case params[:order]
      when 'title'
        @movies = Movie.where(rating: @ratings).order 'title ASC'
        @class_t = :hilite
      when 'release'
        @movies = Movie.where(rating: @ratings).order 'release_date ASC'
        @class_r = :hilite
      else
        @movies = Movie.where(rating: @ratings)
    end
    @all_ratings = Movie.ratings
    # Movie.reset_rating
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
