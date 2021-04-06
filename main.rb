# pre- start checklist

# Feature: User can create an account and sign in.
# Implementation:

# - Prompt user if they would like to create an account or sign in
# - If sign in ask for username and password
# - Check username and password against existing user records
# - Sign in if correct/ show error if not and ask for username and password again
# - If creating an account ask for username and password
# - If username is already existing show error and ask for username and password again
# - If username does not exist, sign user in.

# login

# CSV.open("employees.csv") do |employee_id, password|
#     csv.each do |employee_id, password|
#            login.new(note[0], note[1], note[2], note[3])
#     end
# end

# File.open("employees.csv", "a") {|file|
#   file.write("#{operator_id},#{password}\n")
# }

# require colorize to highlight each option for input
require "csv"
login_in_process = true

def find_employee(id)
  CSV.open("./csv/employees.csv", "r") do |csv|
    record = csv.select { |line| line[0] == id }.first

    if record
      return { operator_id: record[0], password: record[1] }
    end
  end
end

def create_employee(operator_id, password)
  CSV.open("./csv/employees.csv", "a+") do |csv|
      csv << [operator_id, password]
  end
end



while login_in_process
  logged_in = false

  until logged_in
    puts "Welcome to the Offline Vehicle Pre-start Application"
    puts "Please select from the options:"
    puts "LOGIN, CREATE an account or QUIT."
    input = gets.chomp

    if input.downcase == "create"
      validation_run = false
      operator_id_is_valid = false

      until operator_id_is_valid
        puts "That Employee ID already exists..." if validation_run
        puts "Please enter your Employee ID."

        operator_id = gets.chomp
        operator_id_is_valid = find_employee(operator_id).nil?
        validation_run = true
      end

      puts "Please enter a password."
      password = gets.chomp
      create_employee(operator_id, password)
      logged_in = true


    elsif input == "login"
      employee = nil
      input_recieved = false
      until employee
        puts "Incorrect Employee ID" if input_recieved
        puts "Please enter your Employee ID."
        id_input = gets.chomp
        input_recieved = true
        employee = find_employee(id_input)
      end
      puts "Please enter your Password"
      password_input = gets.chomp
      if password_input == employee[:password]
        puts "Login successful"
      else 
        puts "login unsuccessful"
      end
      login_successful = false
    elsif input == "quit"
      login_in_process = false
      logged_in = true
    end
  end
end
