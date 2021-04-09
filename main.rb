require "csv"
require "tty-prompt"

prompt = TTY::Prompt.new
logged_in = false

def find_user(path, index, search)
  CSV.open("./csv/#{path}.csv", "r") do |csv|
    record = csv.select { |line| line[index] == search }.first
    return { username: record[0], password: record[1] } if record
  end
end

def login
  puts "please enter your username."
  username_input = gets.chomp
  admin_user = find_user("admin", 0, username_input)
  admin if admin_user
  valid_username = find_user("users", 0, username_input)
  unless valid_username
    puts "Username doesn't exist!"
    login
  end
  puts "Please enter your password"
  password_input = gets.chomp
  valid_password = find_user("users", 1, password_input)
  return if valid_password

  puts "Incorrect password!"
  login
end

def admin
  puts "Please enter your ADMIN password"
  admin_password = gets.chomp
  valid_admin_password = find_user("admin", 1, admin_password)
  vehicle_list if valid_admin_password

  unless valid_admin_password
    puts "Incorrect ADMIN password"
    admin
  end
end

def new_user
  puts "Please enter a username"
  username_input = gets.chomp
  valid_username = find_user("users", 0, username_input)
  if valid_username
    puts "Username already exist!"
    new_user
  else
    puts "Please enter a password"
    password_input = gets.chomp
    create_user(username_input, password_input)
  end
end

def create_user(username, password)
  CSV.open("./csv/users.csv", "a+") do |csv|
    csv << [username, password]
  end
end

def checklist
  prompt = TTY::Prompt.new
  checklist = CSV.parse(File.read("./csv/checklist.csv"))
  answers = []
  answer_key = { true => "Pass", false => "Fail" }
  checklist.each do |line|
    passed = prompt.yes?(line) do |q|
      q.suffix "Pass/Fail"
    end
    answers.push("#{line} #{answer_key[passed]}")
  end
  answers
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
  p vehicles_to_remove
  del_arr = prompt.multi_select("Which vehicle would you like to delete?", vehicles_to_remove, help: "Space bar to select, Enter to confirm.")
  del_arr.each do |vehicle|
    vehicles_to_remove.delete(vehicle)
  end
  p vehicles_to_remove
  CSV.open("./csv/vehicles.csv", "w") do |csv|
    csv << vehicles_to_remove
  end
end

def vehicle_list
  prompt = TTY::Prompt.new
  print_vehicles
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
  input = prompt.select("Please choose one of the following options:", %w[Login New_User Quit])
  case input

  when "Login"
    login
    logged_in = true
  when "New_User"
    new_user
    logged_in = true
  else
    puts "Thank you please drive safely."
    exit
  end
  next
end

if logged_in
  vehicles = prompt.select("Please select from the following vehicles:", %w[LV1 LV2 LV3 LV4 LV5])
  case vehicles
  when "LV1"
    puts checklist
  when "LV2"
    checklist
  when "LV3"
    checklist
  when "LV4"
    checklist
  when "LV5"
    checklist
  end
end
