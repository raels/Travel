require 'test_helper'

class TripEstimatesControllerTest < ActionController::TestCase
  setup do
    @trip_estimate = trip_estimates(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:trip_estimates)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create trip_estimate" do
    assert_difference('TripEstimate.count') do
      post :create, trip_estimate: { air_cost: @trip_estimate.air_cost, booked_at: @trip_estimate.booked_at, cost_center: @trip_estimate.cost_center, departure_airport: @trip_estimate.departure_airport, departure_city: @trip_estimate.departure_city, destination_airport: @trip_estimate.destination_airport, destination_city: @trip_estimate.destination_city, ended_at: @trip_estimate.ended_at, estimated_car_daily_expense_with_tax: @trip_estimate.estimated_car_daily_expense_with_tax, estimated_hotel_nightly_expense_with_tax: @trip_estimate.estimated_hotel_nightly_expense_with_tax, estimated_total_cost_usd: @trip_estimate.estimated_total_cost_usd, hotel: @trip_estimate.hotel, hotel_nights: @trip_estimate.hotel_nights, manager: @trip_estimate.manager, purpose: @trip_estimate.purpose, rental_car_days: @trip_estimate.rental_car_days, started_at: @trip_estimate.started_at, traveller: @trip_estimate.traveller }
    end

    assert_redirected_to trip_estimate_path(assigns(:trip_estimate))
  end

  test "should show trip_estimate" do
    get :show, id: @trip_estimate
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @trip_estimate
    assert_response :success
  end

  test "should update trip_estimate" do
    put :update, id: @trip_estimate, trip_estimate: { air_cost: @trip_estimate.air_cost, booked_at: @trip_estimate.booked_at, cost_center: @trip_estimate.cost_center, departure_airport: @trip_estimate.departure_airport, departure_city: @trip_estimate.departure_city, destination_airport: @trip_estimate.destination_airport, destination_city: @trip_estimate.destination_city, ended_at: @trip_estimate.ended_at, estimated_car_daily_expense_with_tax: @trip_estimate.estimated_car_daily_expense_with_tax, estimated_hotel_nightly_expense_with_tax: @trip_estimate.estimated_hotel_nightly_expense_with_tax, estimated_total_cost_usd: @trip_estimate.estimated_total_cost_usd, hotel: @trip_estimate.hotel, hotel_nights: @trip_estimate.hotel_nights, manager: @trip_estimate.manager, purpose: @trip_estimate.purpose, rental_car_days: @trip_estimate.rental_car_days, started_at: @trip_estimate.started_at, traveller: @trip_estimate.traveller }
    assert_redirected_to trip_estimate_path(assigns(:trip_estimate))
  end

  test "should destroy trip_estimate" do
    assert_difference('TripEstimate.count', -1) do
      delete :destroy, id: @trip_estimate
    end

    assert_redirected_to trip_estimates_path
  end
end
