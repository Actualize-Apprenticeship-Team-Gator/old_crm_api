class SettingsController < ApplicationController
  def edit
    @setting = current_user.setting
  end

  def update
    
  end
end
