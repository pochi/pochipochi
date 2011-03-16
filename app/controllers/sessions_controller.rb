class SessionsController < ApplicationController
  def new
  end

  def create
    user = if current_user
             create_provider
             message = "Create provider successfully."
             current_user
           else
             message = "Logged in successfully."
             find_user
           end

    if user
      session[:user_id] = user.id
      redirect_to root_url, :notice => message
    else
      flash.now.alert = 'Invaldid email or password'
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to :action => "new", :notice => "Logged out"
  end

  private
  def find_user
    if params[:email] and params[:password]
      authenticate_by_password
    elsif request.env["omniauth.auth"]
      authenticate_by_provider
    end
  end

  def authenticate_by_password
    User.authenticate(params[:email], params[:password])
  end

  def authenticate_by_provider
    auth = request.env["omniauth.auth"]
    if provider = Provider.find_by_name_and_uid(auth["provider"], auth["uid"])
      provider.user
    else
      nil
    end
  end

  def create_provider
    auth = request.env["omniauth.auth"]
    Provider.create_with_omniauth(auth, current_user)
  end
end
