class MoviesController < ApplicationController
  def index
    matching_movies = Movie.all
    @list_of_movies = matching_movies.order({ :created_at => :desc })

    render({ :template => "movie_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_movies = Movie.where({ :id => the_id })
    @the_movie = matching_movies.at(0)

    render({ :template => "movie_templates/show" })
  end

  def create
    # Retrieve the user's inputs from params
      # params hash looks like this
      # {"query_title"=>"1", "query_year"=>"2", "query_duration"=>"3", "query_description"=>"4", "query_image"=>"5", "query_director_id"=>"6"}
    m = Movie.new
    m.title = params.fetch("query_title")
    m.year = params.fetch("query_year")
    m.duration = params.fetch("query_duration")
    m.description = params.fetch("query_description")
    m.image = params.fetch("query_image")
    m.director_id = params.fetch("query_director_id")

    m.save

    redirect_to("/movies")
    # Create a record in the movie table
    # Populate each column with the user input
    # Save
    # Redirect the user back to the /movies URL
  end

end
