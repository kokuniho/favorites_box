class EndUsersController < ApplicationController
  before_action :authenticate_end_user!, except: [:top, :index]
  before_action :ensure_guest_end_user, only: [:edit]
  before_action :set_q, only: [:index, :search]

    def index
      @end_users = EndUser.page(params[:page])
    end

    def show
      @end_user = EndUser.find(params[:id])
      # roomがcreateされた時に、ログインしているユーザーと、「チャットへ」を押されたユーザーの両方をEntriesテーブルに記録
      @currentEndUserEntry = Entry.where(end_user_id: current_end_user.id)
      @EndUserEntry = Entry.where(end_user_id: @end_user.id)
      # 現在ログインしているユーザーではない時
      unless @end_user.id == current_end_user.id
        # roomsが作成されている場合と作成されていない場合に条件分岐
        # 作成されている時、eachで一人づつ取り出し、Entriesテーブル内のroom_idが共通しているのユーザー同士に変数を指定
        @currentEndUserEntry.each do |cu|
          @EndUserEntry.each do |u|
            if cu.room_id == u.room_id then
              @isRoom = true
              @roomId = cu.room_id
            end
          end
        end
        if @isRoom
        else
          @room = Room.new
          @entry = Entry.new
        end
      end
      # タグ検索 タグがあれば、end_userのitemタグからitemを絞り込み
      items = params[:tag_id].present? ? Tag.find(params[:tag_id]).items : @end_user.items.all
      @tag_id = params[:tag_id].present? ? params[:tag_id] : nil
        if params[:sort] == "star"
          items = items.where(end_user_id: params[:id]).order("star DESC")
        elsif params[:sort] == "create"
          items = items.where(end_user_id: params[:id]).order(created_at: :desc)
        else
          items = items.where(end_user_id: params[:id])
            to = Time.current.at_end_of_day
            from = (to - 6.day).at_beginning_of_day
            items = items.all.sort { | a, b |
              b.favorites.where(created_at: from...to).size <=>
              a.favorites.where(created_at: from...to).size
            }
        end
        @items = Kaminari.paginate_array(items).page(params[:page])
        @notifications = current_end_user.passive_notifications
    end

    def edit
      @end_user = EndUser.find(params[:id])
       if @end_user == current_end_user
          render "edit"
       else
          redirect_to edit_end_user_path(current_end_user)
       end
    end

    def update
      @end_user = EndUser.find(params[:id])
      if @end_user.update(end_user_params)
        redirect_to end_user_path(@end_user.id)
        flash[:notice] ="Updated profile successfully!"
      else
        render :edit
      end
    end

    def search
      @results = @q.result
    end

    def finished
      @end_user = current_end_user
    end

    def withdraw
      @end_user = current_end_user
      @end_user.update(is_deleted: true)
      reset_session
      redirect_to root_path
    end

    private

    def set_q
      @q = EndUser.ransack(params[:q])
    end

    def end_user_params
      params.require(:end_user).permit(:name, :introduction, :profile_image, :is_deleted, tag_ids: [])
    end

    def correct_end_user
      @end_user = EndUser.find(params[:id])
       redirect_to(end_user_session_path(end_user_id)) unless @end_user == current_end_user
    end

    def ensure_guest_end_user
      @end_user = EndUser.find(params[:id])
      if @end_user.name == "guestuser"
        redirect_to end_user_path(current_end_user)
      end
    end
end
