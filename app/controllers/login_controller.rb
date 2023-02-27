class LoginController < ApplicationController
  def index
    if session[:valid]
      redirect_to(employees_url)
    end
    if params[:password] && params[:password] != 'admin'
      session[:login_error] = "Invalid password"
      session[:valid] = nil
      redirect_to(login_url)
    elsif params[:password] && params[:password] == 'admin'
      session[:valid] = true
      redirect_to(employees_url)
    end
  end
end
