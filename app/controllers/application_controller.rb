class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  add_flash_types :success, :info, :danger

  helper_method :current_order
  helper_method :logged_in?

  def current_order
  	if session[:order_id]
      current_user.orders.find(session[:order_id])
  	else
  		current_user.orders.new
  end
  end

  def admin
    if !current_user.admin
      redirect_to root_path
      flash[:danger] = 'Your cant do this, because your are not admin'
    end
  end

    def logged_in?
      !current_user.nil?
    end


  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
  end

end
