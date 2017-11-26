namespace :crm_api do
  desc 'Import lead tracker data from CSV to CRM API'
    task :import_lead_data => :environment do
      s3 = Aws::S3::Resource.new(
             region: 'us-east-1',
             access_key_id: ENV['AWS_ACCESS_KEY_ID'],
             secret_access_key: ENV['AWS_SECRET_ACCESS_KEY']
           )
      obj = s3.bucket(ENV['S3_BUCKET_TITLE']).object('leads_copy.csv').get

      CSV.parse(obj.body, :headers => true) do |row|
        @lead = Lead.find_or_create_by(email: row['email']) do |lead|
          lead.created_at = row['created_at']
          lead.updated_at = row['updated_at']
          lead.city = row['city']
          lead.notes = row['notes']
          lead.phone = row['phone']
          lead.old_lead = true
          lead.hot = false
          if row['full_name'].nil?
            lead.first_name = row['first_name']
            lead.last_name = row['last_name']
          elsif !row['full_name'].nil?
            lead.first_name = row['full_name']
            lead.last_name = row['last_name']
          end
          if row['advisor'] == 'n'
            lead.advisor = 'Nick'
          elsif row['advisor']  == 'Z'
            lead.advisor = 'Zev'
          elsif row['advisor'] == 'r'
            lead.advisor = 'Ray'
          end
          unless row['connected'].nil?
            lead.contacted = true
            lead.number_of_dials = 1
          end
          if row['connected'] == 'y'
            lead.connected = true
          elsif row['connected'] == 'x'
            lead.exclude_from_calling = true
          end
          if row['appointment_date'].present?
            lead.appointment_date = row['appointment_date']
          end
        end
        @lead.events.create(name: row['name'], created_at: row['created_at'], updated_at: row['updated_at'])
    end
  end
end