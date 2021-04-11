require_relative "../modules/users"
require_relative "../modules/vehicles"
include Users
include Vehicles

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

describe Vehicles do
  before do
    ENV["CSV_PATH"] = 'test_csv'
  end

  after do
    ENV["CSV_PATH"] = nil
  end

  describe "#print_vehicles" do
    it 'prints list of vehicles' do
      expect(Vehicles.print_vehicles)
    end
  end

  describe "#add_to_vehicle_list" do
    it 'adds vehicle to vehicle csv' do
      new_vehicle_data = { vehicle_make: "make", vehicle_registration: "rego" }
      expect(Vehicles.add_to_vehicle_list(new_vehicle_data[:vehicle_make], new_vehicle_data[:vehicle_registration]))
    end
  end
end
