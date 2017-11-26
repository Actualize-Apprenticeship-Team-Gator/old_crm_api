class CalendarInvitesMailer < ApplicationMailer
  ADVISOR_INFO = {
      "Zev" => {full_name: "Zev Jacobs", phone: "312-909-5575"},
      "Ray" => {full_name: "Ray Nawabi", phone: "510-931-0754"},
      "Nick" => {full_name: "Nick Peterson", phone: "321-759-3239"}
    }
  def appointment(lead)
    @lead = lead
    @advisor_info = ADVISOR_INFO[@lead.advisor]
    # Generate the calendar invite
    ical = Icalendar::Calendar.new
    ical.event do |e|
      e.dtstart     = Icalendar::Values::DateTime.new(@lead.appointment_date)
      # the default calendar invite is for 1 hour, so we don't need to set an endtime
      e.summary     = "ACTUALIZE #{@lead.location}: #{@lead.meeting_type} - #{@lead.first_name} <> #{@lead.advisor}"
      e.description = %Q(

      Hello, #{@lead.first_name}!

      Thank you for your interest in Actualize Coding Bootcamp. Per our
      conversation, you are scheduled for a #{@lead.meeting_type} with our
      Admissions Advisor, #{@advisor_info[:full_name]}. #{@lead.advisor} will
      reach out to you shortly.

      To confirm your appointment, please accept this calendar invite. 

      We look forward to mentoring you on your journey to success!

      #{@advisor_info[:full_name]} 
      #{@advisor_info[:phone]} 
      #{@lead.advisor.downcase}@actualize.co
      )
    end
    ical.publish

    # Add the .ics as an attachment
    attachments['event.ics'] = { mime_type: 'application/ics', content: ical.to_ical }

    mail(from: "#{@lead.advisor.downcase}@actualize.co", to: @lead.email, subject: "ACTUALIZE #{@lead.location}: Meeting - #{@lead.first_name} <> #{@lead.advisor}")
  end
end
