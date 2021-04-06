# Feature: User can fill out a vehicle checklist
# Implementation:

# - Show user list of vehicles
# - Allow user to select vehicle
# - When vehicle is selected guide user through checklist
# - When checklist complete show user a review of selections
# - Prompt user to save, edit or discard the checklist
# ---------------------------------------------------------------
require "csv"

def print_from_csv
  CSV.open("csv/light_vehicles.csv", "a+") do |csv|
    csv.each do |row|
      p row
    end
  end
end

print_from_csv

# CSV.open("csv/light_vehicles.csv", "a+") do |csv|
#   p csv
# end

# light_vehicle = File.open("light_vehicles.csv", "a+")

# cars = []

# while (line = light_vehicle.gets)
# arr = line.split(',')
# cars.push({name: arr[0]})
# end

# file.close
# cars.inspect
# ------------------------------------------------------------------
# selecting_vehicle = true
# while selecting_vehicle
# CSV = CSV.open("vehicle.csv", "a+")
# File = CSV.each("vehicle.csv") do |row|
#   puts row
# end
# end
# puts "please select from the following vehicles"
# -------------------------------------------------------------------------
# p CSV.open(vehicle.csv)

# puts "Please select vehicle: lv1, lv2, lv3, lv4, lv5"
# input = gets.chomp
# if input == lv1
