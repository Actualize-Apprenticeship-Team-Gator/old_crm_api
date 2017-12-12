class SettingsController < ApplicationController

  def edit
    @setting = current_admin.setting || Setting.new
  end

  def update
    current_admin.setting.destroy if current_admin.setting
    if Setting.create(admin_id: current_admin.id, auto_text: params[:auto_text])
      flash[:success] = "Settings Saved!"
      redirect_to '/'
    else
      flash[:warning] = "Update Failed!"
      redirect_back(fallback_location: root_path)
    end
  end
end
