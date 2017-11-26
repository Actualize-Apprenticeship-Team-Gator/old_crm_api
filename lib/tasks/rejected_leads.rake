namespace :crm_api do
  desc 'set exclude_from_calling to true for all rejected leads'
  task :set_rejects_to_no_call => :environment do
    s3 = Aws::S3::Resource.new(
           region: 'us-east-1',
           access_key_id: ENV['AWS_ACCESS_KEY_ID'],
           secret_access_key: ENV['AWS_SECRET_ACCESS_KEY']
         )
    obj = s3.bucket(ENV['S3_BUCKET']).object('rejected_leads.csv').get

    CSV.parse(obj.body, headers: true) do |row|
      @lead = Lead.find_by(email: row['email'])
      @lead.update(exclude_from_calling: true)
    end
  end
end