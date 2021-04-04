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


# require colorize to highlight each option for input
# warnings = []

# login

# CSV.open("login.csv") do |employee_id, password|
#     csv.each do |employee_id, password|
#            login.new(note[0], note[1], note[2], note[3])
#     end
# end

require "csv"
# employee = { employee_id: "1111", password: "pw123" }

# File.open("login.csv", "a") {|file|
    #   file.write("#{operator_id},#{password}\n")
    # }
    
operators_list = []
login_in_process = true

while login_in_process
  logged_in = false
  until logged_in
    puts "Welcome to the Offline Vehicle Pre-start Application"
    puts "Please select from the options:"
    puts "LOGIN, CREATE an account or QUIT."
    input = gets.chomp
    if input == "create"
      puts "Please enter your Employee ID."
      operator_id = gets.chomp
      puts "Please enter a password."
      password = gets.chomp
      operator = {}
      operator[:operator_id] = operator_id
      operator[:password] = password
      operators_list.push(operator)
      CSV.open("login.csv", "a+") do |csv|
        existing_employee = false
        csv.each do |line|
          if line[0] == operator_id
            puts "That Employee ID already exists."
            existing_employee = true
          elsif existing_employee == false
            csv << [operator_id,password]
            logged_in = true
          end
        end
      end
    elsif input == "login"
      puts "Please enter your Employee ID."
      input = gets.chomp
      puts "Please enter your Password"
      input = gets.chomp
      login_successful = false
      CSV.open("login.csv", "r") do |csv|
        csv.each { |line|
        if line[0] == operator_id && line[1] == password
          login_successful = true
          puts "Login successful"
          logged_in = true
        else
          puts "Login unsuccessful! Please check your Employee ID and password and try again."
          login_successful = false
        end
        }
      end
    elsif input == "quit"
      login_in_process = false
      logged_in = true
    end
  end
end
