class NotificationsController < ApplicationController

  def index
    @notifications = current_end_user.passive_notifications
    @notifications.where(checked: false).each do |notification|
    notification.update(checked: true)
    end
  end

  def destroy
    @notification=Notification.find(params[:id])
    @notification.destroy
    redirect_to request.referer
  end
end