require "csv"
require "tty-prompt"

prompt = TTY::Prompt.new

class User < TTY::Prompt
  attr_accessor :user

  def find_user(username)
    CSV.open("../csv/users.csv", "r") do |csv|
      record = csv.select { |line| line[0] == username }.first
      return { username: record[0], password: record[1] } if record
    end
  end

  # def create_user(username, password)
  #   CSV.open("./csv/users.csv", "a+") do |csv|
  #     csv << [username, password]
  #   end
  # end

  def login_menu
    puts "Welcome to the Offline Vehicle Pre-start Application"
    action = self.select("Please choose one of the following options:", %w[Login New_User Quit])
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

  def new_user; end

  def quit; end
end
