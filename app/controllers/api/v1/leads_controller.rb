class Api::V1::LeadsController < ApplicationController

  def index
    @leads = Lead.all
    render "index.json.jbuilder"
  end

  def show
    @lead = Lead.find(params[:id])
    render "show.json.jbuilder"
  end

  def create
    # A lead is created by someone triggering an "event" on the website in 
    # which they submit information like a name and email address. 
    # If this is the first time this particular person triggered an event,
    # they become a lead, so we store both the lead and the particular
    # event they triggered. If they've triggered an event previously and already
    # become a lead in the past, we just record their new event.
    
    @lead = Lead.find_or_create_by(email: params[:email]) do |lead|
      lead.first_name = params[:first_name]
      lead.last_name = params[:last_name]
      lead.phone = params[:phone]
      lead.ip = params[:ip]
      lead.city = params[:city]
      lead.state = params[:state]
      lead.zip = params[:zip]
      lead.created_at = params[:created_at]
      lead.updated_at = params[:updated_at]
    end
    @lead.events.create(name: params[:name], created_at: params[:created_at], updated_at: params[:updated_at])
    render "show.json.jbuilder"
  end

end
