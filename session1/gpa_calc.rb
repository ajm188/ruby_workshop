require 'csv'

class Course
  attr_reader :credits

  GRADE_TABLE = {
    'A' => 4,
    'B' => 3,
    'C' => 2,
    'D' => 1,
    'F' => 0
  }

  def initialize(row)
    @credits = row['Credits'].to_i
    @grade = row['Grade']
  end

  def grade_points
    GRADE_TABLE[@grade] * @credits
  end
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
  # '<<' is an alias for the 'push' method; they do the same thing.
  courses << Course.new(row)
end

grade_points, credits = 0, 0
courses.each do |course|
  grade_points += course.grade_points
  credits += course.credits
end

gpa = grade_points.to_f / credits
puts "GPA: #{gpa}"
puts gpa > 2 ? "Good job!" : "Keep trying!"
