class NotificationsController < ApplicationController

  def index
    #current_end_userの投稿に紐づいた通知一覧
    @notifications = current_end_user.passive_notifications
    #@notificationの中でまだ確認していない(indexに一度も遷移してない)通知のみ
    @notifications.where(checked: false).each do |notification|
      notification.update(checked: true)
    end
  end

  def destroy
    @notification = Notification.find(params[:id])
    @notification.destroy
    redirect_to request.referer
  end

  def destroy_all
    # 通知を全削除
    @notifications = current_end_user.passive_notifications.destroy_all
    redirect_to request.referer
  end
end