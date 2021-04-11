require 'csv'
require 'tty-prompt'
require 'colorize'
require 'tty-font'
require 'pastel'

require_relative "modules/users"
require_relative "modules/vehicles"
require_relative "modules/checklist"

include Users
include Vehicles
include Checklist

pastel = Pastel.new
font = TTY::Font.new(:straight)
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
  pastel = Pastel.new
  puts pastel.cyan("Please enter your username.")
  username_input = $username_from_arg || gets.chomp
  admin_user = Users.find("admin", 0, username_input)
  admin if admin_user
  valid_username = Users.find("users", 0, username_input)
  unless valid_username
    puts "Username doesn't exist!".red
    login
  end
  puts pastel.cyan("Please enter your password")
  password_input = $password_from_arg || gets.chomp
  valid_password = Users.find("users", 1, password_input)
  return username_input if valid_password

  puts "Incorrect password!".red
  login
end

until logged_in
  puts font.write("Welcome").light_blue.on_black
  puts font.write("to the").light_blue.on_black
  puts font.write("Offline Vehicle Pre-start Application").light_blue.on_black
  if $username_from_arg && $password_from_arg
    puts "Bash login successful please select LOGIN to continue".green
    login
  end

  input = prompt.select("Please choose one of the following options:".yellow, %w[Login New_User Quit])
  case input
  when "Login"
    username = login
    logged_in = true
  when "New_User"
    username = new_user
    logged_in = true
  else
    puts pastel.bright_magenta("Thank you please drive safely.")
    exit
  end
  next
end

if logged_in
  vehicle = prompt.select("Please select from the following vehicles:".yellow, select_vehicle)
  answers = checklist
  line = username, vehicle
  answers.each { |array| line.push(array[1]) }
  save_details(line)
  puts "Your vehicle pre-start has been saved!".green
  puts pastel.bright_magenta("Drive Safely")
  exit
end
