require "csv"
require "tty-prompt"
require_relative "modules/users"
include Users

prompt = TTY::Prompt.new
logged_in = false
$username_from_arg = nil

ARGV.each do |arg|
  if arg.include?('-u=')
  $username_from_arg = arg.gsub('-u=', '')
  end
  if arg.include?('-p=')
  $password_from_arg = arg.gsub('-p=', '')
  end
end

def login
  puts "please enter your username."
  username_input = $username_from_arg || gets.chomp
  admin_user = Users.find("admin", 0, username_input)
  admin if admin_user
  valid_username = Users.find("users", 0, username_input)
  unless valid_username
    puts "Username doesn't exist!"
    login
  end
  puts "Please enter your password"
  password_input = $password_from_arg || gets.chomp
  valid_password = Users.find("users", 1, password_input)
  return username_input if valid_password

  puts "Incorrect password!"
  login
end

def admin
  puts "Please enter your ADMIN password"
  admin_password = gets.chomp
  valid_admin_password = Users.find("admin", 1, admin_password)
  vehicle_list if valid_admin_password

  unless valid_admin_password
    puts "Incorrect ADMIN password"
    admin
  end
end



def save_details(line)
  CSV.open("./csv/checklist_results.csv", "a+") do |csv|
    csv << line
  end
end

def checklist
  prompt = TTY::Prompt.new
  checklist = CSV.parse(File.read("./csv/checklist.csv"))
  answers = []
  answer_key = { true => "Pass", false => "Fail" }
  checklist.each do |line|
    passed = prompt.yes?(line[0]) do |q|
      q.suffix "Pass/Fail"
    end
    # answers[line[0]] = answer_key[passed]
    answers.push([line[0], answer_key[passed]])
  end
  answers
end

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
  puts "Enter the make of the vehicle"
  vehicle_make = gets.chomp
  puts "Enter vehicle registration"
  vehicle_registration = gets.chomp
  add_to_vehicle_list(vehicle_make, vehicle_registration)
  puts "vehicle added!"
end

def remove_vehicle
  prompt = TTY::Prompt.new
  vehicles_to_remove = CSV.parse(File.read("./csv/vehicles.csv")).map do |arr|
    arr.join(" ")
  end
  del_arr = prompt.multi_select("Which vehicle would you like to delete?", vehicles_to_remove, help: "Space bar to select, Enter to confirm.")
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

def vehicle_list
  prompt = TTY::Prompt.new
  # print_vehicles
  admin_menu = prompt.select("Administration menu:", %w[Remove_Vehicle Add_Vehicle Quit])
  case admin_menu
  when "Remove_Vehicle"
    remove_vehicle
    vehicle_list
  when "Add_Vehicle"
    add_vehicle
    vehicle_list
  else
    puts "Thank you have a nice day"
    exit
  end
end

until logged_in
  puts "Welcome to the Offline Vehicle Pre-start Application"

  if $username_from_arg && $password_from_arg
    puts "LOGGING IN"
    login
  end

  input = prompt.select("Please choose one of the following options:", %w[Login New_User Vehicles_log Quit])

  case input

  when "Login"
    username = login
    logged_in = true
  when "New_User"
    username = new_user
    logged_in = true
  when "Vehicles_log"
    CSV.open("./csv/checklist_results.csv", "r") do |csv|
      csv.each do |row|
        p row
      end
    end
  else
    puts "Thank you please drive safely."
    exit
  end
  next
end

if logged_in
  vehicle = prompt.select("Please select from the following vehicles:", select_vehicle)
  answers = checklist
  line = username, vehicle
  answers.each { |array| line.push(array[1]) }
  save_details(line)
  puts "Your vehicle pre-start has been saved!"
  puts "Drive Safely"
  exit
end
