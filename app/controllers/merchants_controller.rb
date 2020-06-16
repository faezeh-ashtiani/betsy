class MerchantsController < ApplicationController

  def create
    auth_hash = request.env["omniauth.auth"]
    merchant = Merchant.find_by(uid: auth_hash[:uid], provider: "github")
   
    if merchant 
      flash[:success] = "Logged in as returning user"
    else 
      merchant = Merchant.create_merchant_from_github(auth_hash)
      if merchant.save 
        flash[:status] = "Merchant account created"
      else
        flash[:error] = "Could not create new user account"
        return redirect_to github_login_path
        
      end
    end 

    session[:user_id] = merchant.id

    # if merchant.username == nil
    #   merchant.username = merchant.id
    # end

    redirect_to root_path
  end

  def logout
    session[:user_id] = nil
    flash[:success] = "Successfully logged out"
    redirect_to root_path
    return
  end

  def merchant_products
    @merchant = Merchant.find_by_id(params[:merchant_id])
    @merchant_products = @merchant.products 
  end
end
