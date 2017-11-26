class DailyProgressLogsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @daily_progress_active = "active"
    if params[:email]
      admin = Admin.find_by(email: params[:email])
    else
      admin = current_admin
    end

    if admin
      @logs = admin.daily_progress_logs.order(date: :desc)
    else
      @logs = []
    end
  end
end
