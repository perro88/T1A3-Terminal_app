require "csv"
require "colorize"
require "pastel"
# This module contains methods like searches for username and password info for users and admins
module Users
  def csv_path
    ENV['CSV_PATH'] || "csv"
  end

  def find(path, index, search)
    CSV.open("./#{csv_path}/#{path}.csv", "r") do |csv|
      record = csv.select { |line| line[index] == search }.first
      return { username: record[0], password: record[1] } if record
    end
  end

  def new_user
    pastel = Pastel.new
    puts pastel.cyan("Please enter a username")
    username_input = gets.chomp
    valid_username = Users.find("users", 0, username_input)
    if valid_username
      puts "Username already exist!".red
      new_user
    else
      puts pastel.cyan("Please enter a password")
      password_input = gets.chomp
      create_user(username_input, password_input)
    end
    username_input
  end

  def create_user(username, password)
    CSV.open("./#{csv_path}/users.csv", "a+") do |csv|
      csv << [username, password]
    end
  end

  def admin
    puts "Please enter your ADMIN password".cyan
    admin_password = gets.chomp
    valid_admin_password = Users.find("admin", 1, admin_password)
    vehicle_list if valid_admin_password

    unless valid_admin_password
      puts "Incorrect ADMIN password".red
      admin
    end
  end
end
