require 'csv'
require 'erb'

# read
the_html = File.read("index-as-hash.template.html")
# replace

page_title = "Airplane Ettiquite"

answers = []

CSV.foreach("data.csv", headers: true) do |row|
  answer = row.to_hash#["How often do you travel by plane?"]
  if answer.nil?
    answer = "Did Not Answer"
  end
  answers << answer
end

# remove answers who did not answer
# answers = answers.select {|r| r }

values = {}
answers.each do |answer|
  if values[answer]
    values[answer] += 1
  else
    values[answer] = 1
  end
end

print values.inspect

new_html = ERB.new(the_html).result(binding)
# write

File.open("index.html", "wb") do |file|
  file.write(new_html)
  file.close
end
