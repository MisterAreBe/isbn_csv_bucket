require 'aws-sdk-s3'
# require 'sinatra'
require 'CSV'
require_relative 'isbn.rb'
require_relative 'isbn_csv.rb'

load 'local_ENV.rb' if File.exist?('local_ENV.rb')

# enable :sessions

s3 = Aws::S3::Resource.new(region:'us-east-2')
obj = s3.buckets('rbs-csv-bucket').object_id()
obj.write(Pathname.new('output_isbn_file.csv'))

# get '/' do
#     erb :index
# end

