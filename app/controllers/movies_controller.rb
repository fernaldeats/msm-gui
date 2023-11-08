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
        # Create a record in the movie table
    # Populate each column with the user input
    m = Movie.new
    m.title = params.fetch("query_title")
    m.year = params.fetch("query_year")
    m.duration = params.fetch("query_duration")
    m.description = params.fetch("query_description")
    m.image = params.fetch("query_image")
    m.director_id = params.fetch("query_director_id")

    m.save

    redirect_to("/movies")
  
    # Save
    # Redirect the user back to the /movies URL
  end

def destroy
  the_id = params.fetch("an_id")

  matching_records = Movie.where({ :id => the_id })

  the_movie = matching_records.at(0)

  the_movie.destroy

  redirect_to("/movies")
end

def update
  # Get ID out of params
  m_id = params.fetch("an_id")
 
  # Lookup existing records
  matching_records = Movie.where({ :id => m_id })
  the_movie = matching_records.at(0)
  # Overwrite each column with user inputs
  the_movie.title = params.fetch("query_title")
  the_movie.year = params.fetch("query_year")
  the_movie.duration = params.fetch("query_duration")
  the_movie.description = params.fetch("query_description")
  the_movie.image = params.fetch("query_image")
  the_movie.director_id = params.fetch("query_director_id")

  # Save
  the_movie.save

  # Redirect to movie details page
  redirect_to("/movies/#{the_movie.id}")
 
end

end
