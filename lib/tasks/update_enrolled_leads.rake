namespace :crm_api do
  desc 'update all enrolled leads so enrolled date is 01-01-2016'
  task :update_enrolled_leads => :environment do
    s3 = Aws::S3::Resource.new(
           region: 'us-east-1',
           access_key_id: ENV['AWS_ACCESS_KEY_ID'],
           secret_access_key: ENV['AWS_SECRET_ACCESS_KEY']
         )
    obj = s3.bucket(ENV['S3_BUCKET']).object('enrolled_leads.csv').get

    CSV.parse(obj.body, headers: true) do |row|
      @lead = Lead.find_or_create_by(email: row['email']) do |lead|
        lead.enrolled_date = '01-01-2016 00:00:00'
      end
      @lead.update(enrolled_date: '01-01-2016 00:00:00')
    end
  end
end