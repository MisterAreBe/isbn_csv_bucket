require 'sinatra'
require 'aws-sdk-s3'
require 'csv'
require 'json'
require_relative 'isbn.rb'

enable :sessions

load 'local_ENV.rb' if File.exist?('local_ENV.rb')

s3 = Aws::S3::Client.new(profile: 'MisterAreBe', region: 'us-east-2')

get '/' do
  count = session[:count] || "0"
  isbn = session[:isbn] || []
  valid = session[:valid] || []
  erb :index, :layout => :layout, locals: {count: count, isbn: isbn, valid: valid}
end

post '/store-check' do
  user_isbn = params[:user_isbn]
  count = params[:count]
  stored_isbn = params[:stored_isbn] || []
  stored_valid = params[:stored_valid] || []
  isbn_arr = user_isbn.split("\r\n")
  
  submited = CSV.generate do |csv|
    csv << ["ISBN"]
    isbn_arr.each do |v|
      csv << [v]
    end
  end
  
  s3.put_object(bucket: 'rb-csv-bucket', body: submited, key: "submited#{count}.csv")
  is_valid = []
  isbn_name = []
  
  CSV.parse(submited, :headers => true) do |row|
    if isbn_refa3(row["ISBN"].to_s)
      is_valid << " Valid"
    else
      is_valid << " Invalid"
    end
    if row["ISBN"] != nil
      isbn_name << row["ISBN"].to_s
    else
      isbn_name << ''
    end
  end
  
  validated = CSV.generate do |csv|
    csv << ["ISBN", " Is Valid?"]
    is_valid.each_with_index do |v,i|
      csv << [isbn_name[i], v]
    end
  end
  
  s3.put_object(bucket: 'rb-csv-bucket', body: validated, key: "valid_check#{count}.csv")
  count = count.to_i + 1
  session[:stored_isbn] = stored_isbn
  session[:stored_valid] = stored_valid
  session[:valid] = is_valid
  session[:isbn] = isbn_name
  session[:count] = count
  redirect '/sent'
end

get '/sent' do 
  erb :sent, :layout => :layout, locals: {count: session[:count], valid: session[:valid], isbn: session[:isbn], stored_isbn: session[:stored_isbn], stored_valid: session[:stored_valid]}
end

post '/more' do
  session[:count] = params[:count]
  session[:isbn] = params[:isbn]
  session[:valid] = params[:valid]
  redirect '/'
end