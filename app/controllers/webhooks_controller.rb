class WebhooksController < ApplicationController
  # The webhooks controller are for when someone calls or texts a Twilio 
  # phone number. The way Twilio works is that when someone contacts a Twilio
  # number, Twilio makes a web request to whatever url you set up in your 
  # Twilio account settings, which can be managed at:
  # https://www.twilio.com/console/phone-numbers/incoming

  # This action gets called when someone dials our Twilio number:
  def incoming_voice
    twiml = Twilio::TwiML::Response.new do |r|
      if params['From'] and params['From'] != ''
        r.Dial callerId: params['From'] do |d|
          # Connect the incoming call with our call converter's phone:
          d.Number ENV['EMPLOYEE_PHONE_NUMBER']
        end
      end
    end

    render xml: twiml.text
  end

  # This action gets called when someone texts our Twilio number:
  def incoming_text
    # Looks up the incoming phone number in our database and
    # retrieves the lead if found:
    begin
      standard_phone = Phoner::Phone.parse(params['From'], country_code: '1').to_s
      @lead = Lead.find_by(standard_phone: standard_phone) if standard_phone
    rescue
      # An exception may happen if the texter's phone number has a very unusual
      # format. We can just move on, as finding the texter's number in our
      # database is not critical.
    end

    # If we do find the texter in our database, we provide extra info about
    # this lead to our call converter:
    extra_info = @lead.email if @lead

    # We text the texter's message to the call converter's phone:
    @client = Twilio::REST::Client.new
    @client.messages.create(
      from: ENV['TWILIO_PHONE_NUMBER'],
      to: ENV['EMPLOYEE_PHONE_NUMBER'],
      body: "Message from #{params['From']}: #{params['Body']}. Extra Info: #{extra_info}"
    )
  end

end
