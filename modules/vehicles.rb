require "csv"
require "colorize"
require "pastel"

# This module contains methods that can add, remove, and print the list of vehicles
# most methods are activated with the admin login
# Otherwise used for when a user selects a vehicle
module Vehicles
  def select_vehicle
    select_vehicle = CSV.parse(File.read("./csv/vehicles.csv")).map do |arr|
      arr.join(" ")
    end
  end
 
  def print_vehicles
    CSV.open("./csv/vehicles.csv", "a+") do |csv|
      csv.each do |row|
        p row
      end
    end
  end
 
  def add_to_vehicle_list(vehicle_make, vehicle_registration)
    CSV.open("./csv/vehicles.csv", "a+") do |csv|
      csv << [vehicle_make, vehicle_registration]
    end
  end
 
  def add_vehicle
    pastel = Pastel.new
    puts pastel.cyan("Enter the make of the vehicle")
    vehicle_make = gets.chomp
    puts pastel.cyan("Enter vehicle registration")
    vehicle_registration = gets.chomp
    add_to_vehicle_list(vehicle_make, vehicle_registration)
    puts "vehicle added!".green
  end

  def remove_vehicle
    prompt = TTY::Prompt.new
    vehicles_to_remove = CSV.parse(File.read("./csv/vehicles.csv")).map do |arr|
      arr.join(" ")
    end
    del_arr = prompt.multi_select("Which vehicle would you like to delete?".yellow, vehicles_to_remove, help: "Space bar to select, Enter to confirm.".blue)
    del_arr.each do |vehicle|
      vehicles_to_remove.delete(vehicle)
    end
    vehicles_to_remove.map!(&:split)
    CSV.open("./csv/vehicles.csv", "w") do |csv|
    end
    CSV.open("./csv/vehicles.csv", "a") do |csv|
      vehicles_to_remove.each { |v| csv << v }
    end
  end

  def vehicle_log
    CSV.open("./csv/checklist_results.csv", "r") do |csv|
      csv.each do |row|
        p row
      end
    end
  end

  def vehicle_list
    pastel = Pastel.new
    prompt = TTY::Prompt.new
    print_vehicles
    admin_menu = prompt.select("Administration menu:".yellow, %w[Remove_Vehicle Add_Vehicle Vehicles_log Quit])
    case admin_menu
    when "Remove_Vehicle"
      remove_vehicle
      vehicle_list
    when "Add_Vehicle"
      add_vehicle
      vehicle_list
    when "Vehicles_log"
      vehicle_log
      vehicle_list
    else
      puts pastel.bright_magenta("Thank you have a nice day")
      exit
    end
  end
end