class DirectorsController < ApplicationController
  def index
    matching_directors = Director.all
    @list_of_directors = matching_directors.order({ :created_at => :desc })

    render({ :template => "director_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_directors = Director.where({ :id => the_id })
    @the_director = matching_directors.at(0)

    render({ :template => "director_templates/show" })
  end

  def max_dob
    directors_by_dob_desc = Director.
      all.
      where.not({ :dob => nil }).
      order({ :dob => :desc })

    @youngest = directors_by_dob_desc.at(0)

    render({ :template => "director_templates/youngest" })
  end

  def min_dob
    directors_by_dob_asc = Director.
      all.
      where.not({ :dob => nil }).
      order({ :dob => :asc })
      
    @eldest = directors_by_dob_asc.at(0)

    render({ :template => "director_templates/eldest" })
  end

  def create
    # Retrieve the user's inputs from params
      # params hash looks like this
      # {"query_name"=>"1", "query_dob"=>"1996-12-04", "query_bio"=>"Asdf", "query_image"=>"AAA"}
        # Create a record in the movie table
    # Populate each column with the user input
    dir = Director.new
    dir.name = params.fetch("query_name")
    dir.dob = params.fetch("query_dob")
    dir.bio = params.fetch("query_bio")
    dir.image = params.fetch("query_image")

    dir.save

    redirect_to("/directors")
  
    # Save
    # Redirect the user back to the /directors URL
  end

def destroy
  the_id = params.fetch("an_id")

  matching_records = Director.where({ :id => the_id })

  the_director = matching_records.at(0)

  the_director.destroy

  redirect_to("/directors")
end

def update
  # Get ID out of params
  dir_id = params.fetch("an_id")
 
  # Lookup existing records
  matching_records = Director.where({ :id => dir_id })
  the_director = matching_records.at(0)
  # Overwrite each column with user inputs
  the_director.name = params.fetch("query_name")
  the_director.dob = params.fetch("query_dob")
  the_director.bio = params.fetch("query_bio")
  the_director.image = params.fetch("query_image")

  # Save
  the_director.save

  # Redirect to movie details page
  redirect_to("/directors/#{the_director.id}")
 
end

end
