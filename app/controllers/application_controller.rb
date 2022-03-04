class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  # サインイン、ログアウト後にroot_path以外を遷移させたい時
  # def after_sign_in_path_for(resource)
  #   root_path
  # end
  
  # def after_sign_out_path_for(resource)
  #   root_path
  # end
  
  protected
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,keys: [:email])
    # added_attrs = [:name, :email, :password, :password_confirmation, :remember_me]
    # devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    # devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end
end
