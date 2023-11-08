class ActorsController < ApplicationController
  def index
    matching_actors = Actor.all
    @list_of_actors = matching_actors.order({ :created_at => :desc })

    render({ :template => "actor_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_actors = Actor.where({ :id => the_id })
    @the_actor = matching_actors.at(0)
      
    render({ :template => "actor_templates/show" })
  end

  def create
    # Retrieve the user's inputs from params
      # params hash looks like this
      # {"query_name"=>"1", "query_dob"=>"1996-12-04", "query_bio"=>"Asdf", "query_image"=>"AAA"}
        # Create a record in the movie table
    # Populate each column with the user input
   act = Actor.new
   act.name = params.fetch("query_name")
   act.dob = params.fetch("query_dob")
   act.bio = params.fetch("query_bio")
   act.image = params.fetch("query_image")

   act.save

    redirect_to("/actors")
  
    # Save
    # Redirect the user back to the /actors URL
  end

def destroy
  the_id = params.fetch("an_id")

  matching_records = Actor.where({ :id => the_id })

  the_actor = matching_records.at(0)

  the_actor.destroy

  redirect_to("/actors")
end

def update
  # Get ID out of params
 act_id = params.fetch("an_id")
 
  # Lookup existing records
  matching_records = Actor.where({ :id =>act_id })
  the_actor = matching_records.at(0)
  # Overwrite each column with user inputs
  the_actor.name = params.fetch("query_name")
  the_actor.dob = params.fetch("query_dob")
  the_actor.bio = params.fetch("query_bio")
  the_actor.image = params.fetch("query_image")

  # Save
  the_actor.save

  # Redirect to movie details page
  redirect_to("/actors/#{the_actor.id}")
 
end

end
