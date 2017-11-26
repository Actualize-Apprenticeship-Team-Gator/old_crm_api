require 'test_helper'

class SettingsControllerTest < ActionDispatch::IntegrationTest
  test "should get dashboard" do
    get settings_dashboard_url
    assert_response :success
  end

end
