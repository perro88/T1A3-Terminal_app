# require colorize to highlight each option for input
require "csv"
require "tty-prompt"
require_relative "./classes/user"

prompt = TTY::Prompt.new

def login_menu
  puts "Welcome to the Offline Vehicle Pre-start Application"
  action = prompt.select("Please choose one of the following options:", %w[Login New_User Quit])
  start_action(action)
end

def start_action(action)
  case action
  when "Login"
    login
  when "New_User"
    new_user
  else
    quit
  end
end

def login
  if user
    puts "Please enter your username."
    username_input = get.chomp
    self.user = find_user(username_input)
  else
    puts "Username doesn't exist!"
  end
end

def find_user(username)
  CSV.open("./csv/users.csv", "r") do |csv|
    record = csv.select { |line| line[0] == username }.first
    return { username: record[0], password: record[1] } if record
  end
end

login_menu

def create_user(username, password)
  CSV.open("./csv/users.csv", "a+") do |csv|
    csv << [username, password]
  end
end

class App < TTY::Prompt
  attr_accessor :is_logged_in, :user, :wrong_password, :show_username_warning

def start
  puts "Welcome to the Offline Vehicle Pre-start Application"
  action = self.select("What would you like to do?", %w[login create_account quit])
  start_action(action)
end

def start_action(action)
  case action
  when "login"
    login
  when "create_account"
    puts "create account"
  else
    puts "Quit"
  end
end

def login
  puts "login method"
  unless user
    puts "Username doesn't exist" if show_username_warning
    puts "Please enter your username."
    username_input = gets.chomp
    self.user = find_user(username_input)

    self.show_username_warning = true

    login unless user
  end

  puts "Wrong password" if wrong_password
  puts "Please enter your Password"
  password_input = gets.chomp

  self.is_logged_in = password_input == user[:password]

  if is_logged_in
    puts "Login successful"
    nil
  else
    puts "IS LOGGED IN#{is_logged_in}"
    self.wrong_password = true
    login
puts "login unsuccessful"
    end
  end
end

App.new.start

while login_in_process
  logged_in = false

  until logged_in
    puts "Welcome to the Offline Vehicle Pre-start Application"

    input = prompt.select("What would you like to do?", %w(login create_account quit))
_
    if input.downcase == "create_account"
      validation_run = false
      username_is_valid = false

      until username_is_valid
        puts "That username already exists..." if validation_run
        puts "Please enter your username."

        username_input = gets.chomp
        username_is_valid = find_user(username_input).nil?
        validation_run = true
      end

      puts "Please enter a password."
      password = gets.chomp

      create_user(username_input, password)
      logged_in = true

    elsif input == "login"
  elsif input == "quit"
login_in_process = false
logged_in = true
end
end
#   end
# end



  #   CSV.open("./csv/checklist.csv", "a+") do |csv|
#     csv.each do |row|
#       puts row
#     end
#   end