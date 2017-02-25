class SessionsController < ApplicationController
  def new
    # renderöi kirjautumissivun
  end

  def create
    user = User.find_by username: params[:username]
    if user
      if user && user.authenticate(params[:password]) && user.active
        session[:user_id] = user.id
        redirect_to user_path(user), notice: "Welcome back!"
      else
        if user.active
          redirect_back(fallback_location: :new, alert: "Username and password do not match!")
        else
          redirect_back(fallback_location: new, alert: "User account is frozen!")
        end
      end
    else
      redirect_back(fallback_location: new, alert: "No such account!")
    end
  end

  def destroy
    # nollataan sessio
    session[:user_id] = nil
    # uudelleenohjataan sovellus pääsivulle
    redirect_to :root
  end
end