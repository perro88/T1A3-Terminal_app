require "test/unit"
require_relative "../classes/vehicle"

class VehicleTest < Test::Unit::TestCase
  def setup
    @vehicle = Vehicle.new("make", "registration")
  end

  def test_new_instance
    @vehicle
    assert_not_nil(@vehicle)
  end

  def test_vehicle
    @vehicle
    assert_equal("make", @vehicle.make)
  end

  def test_registration
    @vehicle
    assert_equal("registration", @vehicle.registration)
  end

  def test_full_vehicles_details
    @vehicle
    assert_equal("make registration", @vehicle.full_vehicle_details)
  end

  def test_no_params
    assert_raise do
      @vehicle = Vehicle.new
    end
  end
end
