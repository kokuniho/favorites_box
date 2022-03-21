# frozen_string_literal: true

class EndUsers::SessionsController < Devise::SessionsController
  # before_action :reject_inactive_end_user, only: [:create]
  before_action :end_user_state, only: [:create]
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
  protected
  def end_user_state
      @end_user = EndUser.find_by(name: params[:end_user][:name].downcase)
      return if !@end_user
      if (@end_user.valid_password?(params[:end_user][:password]) && (@end_user.active_for_authentication? == false))
        redirect_to new_end_user_registration_path
      end
  end
end
