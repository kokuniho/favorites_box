class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  # サインイン、ログアウト後にroot_path以外を遷移させたい時
  def after_sign_in_path_for(resource)
     end_user_path(current_end_user)
  end
  
  
  
  protected
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,keys: [:email])
  end
end
