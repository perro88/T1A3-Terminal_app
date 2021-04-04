# Feature: User can fill out a vehicle checklist
# Implementation:

# - Show user list of vehicles
# - Allow user to select vehicle
# - When vehicle is selected guide user through checklist
# - When checklist complete show user a review of selections
# - Prompt user to save, edit or discard the checklist

require "csv"

puts "please select from the following vehicles"
CSV.open(vehicle.csv, "r") do |csv|
  p csv.each
end
