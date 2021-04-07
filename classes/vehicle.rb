# Feature: User can fill out a vehicle checklist
# Implementation:

# - Show user list of vehicles
# - Allow user to select vehicle
# - When vehicle is selected guide user through checklist
# - When checklist complete show user a review of selections
# - Prompt user to save, edit or discard the checklist
# ---------------------------------------------------------------
require "tty-prompt"
require "csv"
prompt = TTY::Prompt.new

class Vehicle < TTY::Prompt
  def initialize
  end
end

# def print_from_csv
#   CSV.open("csv/light_vehicles.csv", "a+") do |csv|
#     csv.each do |row|
#       p row
#     end
#   end
# end

# print_from_csv
