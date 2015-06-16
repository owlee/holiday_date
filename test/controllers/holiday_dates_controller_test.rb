require 'test_helper'

class HolidayDatesControllerTest < ActionController::TestCase
  setup do
    @holiday_date = holiday_dates(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:holiday_dates)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create holiday_date" do
    assert_difference('HolidayDate.count') do
      post :create, holiday_date: { calendar_date_id: @holiday_date.calendar_date_id, holiday_id: @holiday_date.holiday_id }
    end

    assert_redirected_to holiday_date_path(assigns(:holiday_date))
  end

  test "should show holiday_date" do
    get :show, id: @holiday_date
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @holiday_date
    assert_response :success
  end

  test "should update holiday_date" do
    patch :update, id: @holiday_date, holiday_date: { calendar_date_id: @holiday_date.calendar_date_id, holiday_id: @holiday_date.holiday_id }
    assert_redirected_to holiday_date_path(assigns(:holiday_date))
  end

  test "should destroy holiday_date" do
    assert_difference('HolidayDate.count', -1) do
      delete :destroy, id: @holiday_date
    end

    assert_redirected_to holiday_dates_path
  end
end
