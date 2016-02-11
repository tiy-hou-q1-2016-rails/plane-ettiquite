require 'csv'
require 'erb'
# read
the_html = File.read("index.template.html")
# replace

page_title = "Airplane Ettiquite"

shared_count = 0
first_count = 0
middle_count = 0
window_aisle_count = 0

CSV.foreach("data.csv", headers: true) do |row|

  answer =  row.to_hash["In a row of three seats, who should get to use the two arm rests?"]

  if answer == "The arm rests should be shared"
    shared_count += 1
  elsif answer == "Whoever puts their arm on the arm rest first"
    first_count += 1
  elsif answer == "The person in the middle seat gets both arm rests"
    middle_count += 1
  elsif answer == "The people in the aisle and window seats get both arm rests"
    window_aisle_count += 1
  end

end

new_html = ERB.new(the_html).result(binding)
# write

File.open("index.html", "wb") do |file|
  file.write(new_html)
  file.close
end
