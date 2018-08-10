require 'aws-sdk-s3'
require 'CSV'
require 'json'
require_relative 'isbn.rb'
require_relative 'isbn_csv.rb'

load 'local_ENV.rb' if File.exist?('local_ENV.rb')

s3 = Aws::S3::Client.new(profile: 'MisterAreBe', region: 'us-east-2')

x = s3.get_object(bucket: 'rb-csv-bucket', key: 'input_isbn_file.csv')
temp = []
acorn = []
CSV.parse(x.body, :headers => true) do |row|
  if isbn_refa3(row[" ISBN"].to_s)
    temp << "Valid"
  else
    temp << "Invalid"
  end
  if row[" ISBN"] != nil
    acorn << row[" ISBN"].to_s
  else
    acorn << ''
  end
end
puts "#{temp}"
puts "#{acorn}"

validated = CSV.generate do |csv|
  csv << [" ISBN", " Is Valid?"]
  temp.each_with_index do |v,i|
    csv << [acorn[i], v]
  end
end

s3.put_object(bucket: 'rb-csv-bucket', body: validated, key: 'output_isbn_file.csv')