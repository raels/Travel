require 'test_helper'

class Charts::SamplesControllerTest < ActionController::TestCase
  setup do
    @charts_sample = charts_samples(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:charts_samples)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create charts_sample" do
    assert_difference('Charts::Sample.count') do
      post :create, charts_sample: {  }
    end

    assert_redirected_to charts_sample_path(assigns(:charts_sample))
  end

  test "should show charts_sample" do
    get :show, id: @charts_sample
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @charts_sample
    assert_response :success
  end

  test "should update charts_sample" do
    put :update, id: @charts_sample, charts_sample: {  }
    assert_redirected_to charts_sample_path(assigns(:charts_sample))
  end

  test "should destroy charts_sample" do
    assert_difference('Charts::Sample.count', -1) do
      delete :destroy, id: @charts_sample
    end

    assert_redirected_to charts_samples_path
  end
end
