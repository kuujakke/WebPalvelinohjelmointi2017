class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include ActionView::Helpers::NumberHelper

  # määritellään, että metodi current_user tulee käyttöön myös näkymissä
  helper_method :current_user
  helper_method :round

  def current_user
    return nil if session[:user_id].nil?
    User.find(session[:user_id])
  end

  def ensure_that_user_is_admin
    redirect_to root_path, notice:'you should be administrator to do that' unless current_user.admin
  end

  def ensure_that_signed_in
    redirect_to signin_path, notice:'you should be signed in' if current_user.nil?
  end

  def round(param)
    number_with_precision(param, precision: 1)
  end

end
