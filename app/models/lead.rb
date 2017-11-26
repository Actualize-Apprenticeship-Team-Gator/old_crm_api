class Lead < ApplicationRecord
  has_many :events

  before_save :standardize_phone

  attr_accessor :call_mode

  # The algorithm that decides which lead the call converter should call next
  # based on which lead is most likely to lead to a successful call. This algorithm
  # may change based on which call converter is calling.
  def self.next(admin_email=nil)
    return Lead.joins(:events).where(old_lead: false).where(exclude_from_calling: false).where(contacted: false).where(bad_number: false).where('enrolled_date is null').where("phone <> ''").where("events.name = 'Started Application'").order(:updated_at).last
  end

  # Send an automated text to a lead:
  def text
    @client = Twilio::REST::Client.new
    @client.messages.create(
      from: ENV['TWILIO_PHONE_NUMBER'],
      to: self.phone,
      body: 'Hi - this is Rena from Actualize. Do you have a minute to chat?'
    )
  end

  def full_name
    "#{self.first_name} #{self.last_name}"
  end

  def processed_within_minutes
    return 'not called' unless self.process_time
    number_of_seconds = self.process_time - self.created_at
    return "#{(number_of_seconds / 60).to_i} minutes"
  end

  # Reset a lead as if it's brand new. This is useful for manual testing.
  def reset
    self.update(hot: true, contacted: false, connected: false, exclude_from_calling: false, appointment_date: nil, advisor: nil, number_of_dials: 0)
  end

  private

  def standardize_phone
    begin
      self.standard_phone = Phoner::Phone.parse(self.phone, country_code: '1').to_s
    rescue
      # We'll ignore an exception that could happen if the given phone 
      # number has a very unusual format
    end
  end

  def should_be_left_a_message
    # We tried dialing a valid number but the lead didn't answer their phone:
    self.contacted && !self.bad_number && !self.connected
  end
end
