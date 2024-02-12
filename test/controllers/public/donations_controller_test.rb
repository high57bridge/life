require "test_helper"

class Public::DonationsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_donations_index_url
    assert_response :success
  end

  test "should get update" do
    get public_donations_update_url
    assert_response :success
  end

  test "should get new" do
    get public_donations_new_url
    assert_response :success
  end
end
