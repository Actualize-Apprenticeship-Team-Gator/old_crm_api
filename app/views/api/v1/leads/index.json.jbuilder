json.array!  @leads.each do |lead|
  json.(lead, :id, :first_name, :last_name, :email, :phone, :ip, :city, :state,
  :zip, :contacted, :appointment_date, :notes, :created_at, :updated_at)
  json.events lead.events, :id, :lead_id, :name, :created_at, :updated_at
end
