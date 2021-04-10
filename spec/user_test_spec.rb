require "test/unit"
require_relative "../modules/users"
include Users 

describe Users do
  before do
    ENV["CSV_PATH"] = 'test_csv'
  end

  after do 
    ENV["CSV_PATH"] = nil
  end

  describe "#find" do
    it 'returns the user if found' do
      expect(Users.find("users", 0, "testuser")).to eq(
        username: 'testuser', password: "password"
      )
    end

    it 'returns the nil if user not found' do
      expect(Users.find("users", 0, "non_existing_user")).to be nil
    end
  end

  describe "#create_user" do
    it 'outputs new user if not already in database' do
      new_user_data = { username: "username",password: "password" }
      Users.create_user(new_user_data[:username], new_user_data[:password])

      expect(Users.find("users", 0, new_user_data[:username])).to eq(new_user_data)
    end
  end
end
