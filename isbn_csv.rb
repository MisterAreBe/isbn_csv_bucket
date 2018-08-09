require 'CSV'
require_relative 'isbn.rb'

x = CSV.read("input_isbn_file.csv")
temp = []
acorn = []

x.each do |v|
    temp << v[1]
end

temp.each do |isbn|
    acorn << isbn_refa3(isbn)
end

x.each_with_index do |v,i|
    if acorn[i] == true
        v << "Valid"
    else
        v << "Invalid"
    end
end

CSV.open("output_isbn_file.csv", "wb") do |csv|
   x.each do |v|
    z = v.join(", ")
    csv << [z]
   end
end