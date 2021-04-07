require "csv"
require "tty-prompt"

prompt = TTY::Prompt.new
logged_in = false

def find_user(username)
  CSV.open("./csv/users.csv", "r") do |csv|
    record = csv.select { |line| line[0] == username }.first
    return { username: record[0], password: record[1] } if record
  end
end

def find_password(password)
  CSV.open("./csv/users.csv", "r") do |csv|
    record = csv.select { |line| line [1] == password }.first
    return {username: record[0], password: record[1] } if record
  end
end

def login
  puts "please enter your username."
  username_input = gets.chomp
  valid_username = find_user(username_input)
  unless valid_username
    puts "Username doesn't exist!"
    login
  end
  puts "Please enter your password"
  password_input = gets.chomp
  valid_password = find_password(password_input)
  return if valid_password

  puts "incorrect password!"
  login
end

def new_user
  puts "Please enter a username"
  username_input = gets.chomp
  valid_username = find_user(username_input)
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
    break
  end
  next
end

if logged_in
  vehicles = prompt.select("Please select from the following vehicles:", %w[LV1 LV2 LV3 LV4 LV5])
  case vehicles
  when "LV1"
    puts "lv1"
  end
end
