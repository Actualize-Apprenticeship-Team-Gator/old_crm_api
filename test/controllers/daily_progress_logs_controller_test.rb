require 'test_helper'

class DailyProgressLogsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get daily_progress_logs_index_url
    assert_response :success
  end

end
