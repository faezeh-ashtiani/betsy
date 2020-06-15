class ApplicationController < ActionController::Base

  def current_merchant
    if session[:user_id] == nil
      return nil
    else
      merchant = Merchant.find(session[:user_id])
    return merchant
    end
  end

  def require_login
   
    if current_merchant.nil?
      flash[:error] = "You must be logged in to do this"
      redirect_to root_path
    end
  end
end
