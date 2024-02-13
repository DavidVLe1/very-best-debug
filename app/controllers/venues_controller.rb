class VenuesController < ApplicationController

  def index
    matching_venues = Venue.all
    @venues = matching_venues.order(:created_at)

    render({ :template => "venue_templates/venue_list" })
  end

  def show
    venue_id = params.fetch("an_id")
    matching_venues = Venue.where({ :id => venue_id })
    @the_venue = matching_venues.at(0)

    render({ :template => "venue_templates/details" })
  end

  def create
    #Parameters: {"query_address"=>"123 street", "query_name"=>"jake the dog", "query_neighborhood"=>"adventure square"}
    venue = Venue.new
    venue.address = params.fetch("query_address")
    venue.name = params.fetch("query_name")
    venue.neighborhood = params.fetch("query_neighborhood")
    venue.save

    url_next = "/venues/"+venue.id.to_s
    redirect_to(url_next)
  end
  
  def update
    the_id = params.fetch("the_id")

    @venue = Venue.where({ :id => the_id }).at(0)
    @venue.address = params.fetch("query_address")
    @venue.name = params.fetch("query_name")
    @venue.neighborhood = params.fetch("query_neighborhood")
    @venue.save
    
    redirect_to("/venues/#{the_id.to_s}")
  end

  def destroy
    the_id = params.fetch("id_to_delete")
    matching_venues = Venue.where({ :id => the_id }).at(0)
    venue = matching_venues
    venue.destroy

    redirect_to("/venues")
  end

end
