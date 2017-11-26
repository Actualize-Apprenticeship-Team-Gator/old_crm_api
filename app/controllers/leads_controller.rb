class LeadsController < ApplicationController
  before_action :authenticate_admin!, except: [:token, :voice, :text]

  def index
    @all_leads_active = "active"
    @leads = Lead.where("phone <> ''").order(created_at: :desc)
    # If someone used the search box:
    @leads = Lead.where("first_name ILIKE ? OR last_name ILIKE ? OR email ILIKE ? OR phone ILIKE ?", "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%").order(created_at: :desc) if params[:search]
  end

  # This is a special feature for call converters who can just call lead after
  # lead without thinking. That is, an automated algorithm decides who the 
  # call converter should call next based on which lead is most likely to answer
  # their phone at this time.
  def next
    @outbound_mode_active = "active"
    @lead = Lead.next(current_admin.email)
    @call_mode = true
    if @lead
      render :edit
    else
      redirect_to '/no_leads'
    end
  end

  def new
    @lead = Lead.new
  end

  def create
    @lead = Lead.create(lead_params)
    flash[:success] = "Lead added!"
    redirect_to '/'
  end

  def edit
    @lead = Lead.find_by(id: params[:id])

    # We grab the entire text history from the Twilio API
    client = Twilio::REST::Client.new ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN']
    messages_from_lead = client.account.messages.list({
                  :to   => ENV['TWILIO_PHONE_NUMBER'], 
                  :from => @lead.phone
    })
    messages_from_call_converter = client.account.messages.list({
                  :to   => @lead.phone,
                  :from => ENV['TWILIO_PHONE_NUMBER']
    })
    @messages = (messages_from_lead + messages_from_call_converter).sort_by {|m| m.date_sent}
  end

  def update
    @lead = Lead.find_by(id: params[:id])
    if @lead.update(lead_params)    
      flash[:success] = "Lead saved!"
      redirect_to '/'
    else
      flash[:error] = "ERROR: We could not update this lead."
      render :next
    end
  end

  # This action is called by Twilio when preparing to make outbound voice calls
  # through the browser
  def token
    identity = Faker::Internet.user_name.gsub(/[^0-9a-z_]/i, '')

    capability = Twilio::Util::Capability.new ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN']
    # The Twilio 
    capability.allow_client_outgoing ENV['TWILIO_TWIML_APP_SID']
    capability.allow_client_incoming identity
    token = capability.generate

    render json: {identity: identity, token: token}
  end

  # Make voice calls through the browser. This web request gets called by Twilio
  # based on your Twilio settings, which can be modified at 
  # https://www.twilio.com/console/voice/runtime/twiml-apps
  def voice
    from_number = params['FromNumber'].blank? ? ENV['TWILIO_CALLER_ID'] : params['FromNumber']
    twiml = Twilio::TwiML::Response.new do |r|
      if params['To'] and params['To'] != ''
        r.Dial callerId: from_number do |d|
          # wrap the phone number or client name in the appropriate TwiML verb
          # by checking if the number given has only digits and format symbols
          if params['To'] =~ /^[\d\+\-\(\) ]+$/
            d.Number params['To']
          else
            d.Client params['To']
          end
        end
      else
        r.Say "Thanks for calling!"
      end
    end

    render xml: twiml.text
  end

  # Text from the browser:
  def text
    @client = Twilio::REST::Client.new
    @client.messages.create(
      from: ENV['TWILIO_PHONE_NUMBER'],
      to: params[:phone],
      body: params[:body]
    )

    render nothing: true
  end

  def no_leads
  end

  private

  def lead_params
    params.require(:lead).permit(:first_name, :last_name, :email, :phone, :city, :state, :zip, :contacted, :appointment_date, :notes, :connected, :bad_number, :advisor, :location, :first_appointment_set, :first_appointment_actual, :first_appointment_format, :second_appointment_set, :second_appointment_actual, :second_appointment_format, :enrolled_date, :deposit_date, :sales, :collected, :status, :next_step, :rep_notes, :exclude_from_calling, :meeting_type, :meeting_format)
  end
end
