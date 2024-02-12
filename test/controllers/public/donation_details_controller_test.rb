require "test_helper"

class Public::DonationDetailsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_donation_details_index_url
    assert_response :success
  end

  test "should get show" do
    get public_donation_details_show_url
    assert_response :success
  end
end
