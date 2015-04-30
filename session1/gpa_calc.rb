require 'csv'

class Course
  # TODO
end

# ARGV contains the command line arguments. This basically "String[] args" from
# Java.
if ARGV.empty?
  puts "ruby gpa_calc.rb FILE"
  exit
end

file = ARGV[0]

courses = []
CSV.read(file, headers: true).each do |row|
  # TODO
end

grade_points, credits = 0, 0
courses.each do |course|
  # TODO
end

gpa = grade_points.to_f / credits
puts "GPA: #{gpa}"
puts gpa > 2 ? "Good job!" : "Keep trying!"
