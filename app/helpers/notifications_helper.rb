module NotificationsHelper



  def notification_form(notification)
     @visitor = notification.visitor
     @comment = nil
     your_item = link_to 'あなたの投稿', item_path(notification), style:"font-weight: bold;"
     @visitor_comment = notification.item_comment_id
     #notification.actionがfollowかlikeかcommentか
     case notification.action
      when "follow" then
       tag.a(notification.visitor.name, href:end_user_path(@visitor), style: "font-weight: bold;")+"さんがあなたをフォローしました!"
      when "favorite" then
       tag.a(notification.visitor.name, href:end_user_path(@visitor), style: "font-weight: bold;")+"さんが"+tag.a('あなたの投稿', href:item_path(notification.item_id), style:"font-weight: bold;")+"にいいねしました!"
      when "item_comment" then
       @comment = ItemComment.find_by(id: @visitor_comment)&.comment
       tag.a(@visitor.name, href: end_user_path(@visitor), style:"font-weight: bold;")+"さんが"+tag.a('あなたの投稿', href:item_path(notification.item_id), style:"font-weight: bold;")+"にコメントしました!"
     end
  end




  def unchecked_notifications
    @notifications = current_end_user.passive_notifications.where(checked: false)
  end


end


