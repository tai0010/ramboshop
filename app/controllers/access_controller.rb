class AccessController < ApplicationController
  before_action :confirm_logged_in, :only=>"index"
  
    def index
      
    end
    
    def login
    end
    
    def attempt_login
    if params[:email].present? && params[:password].present?
      found_user = Uzivatel.where(:email => params[:email]).first
      if found_user
        authorized_user = found_user.authenticate(params[:password])
      end
    end
    if authorized_user
      session[:user_id] = authorized_user.id
      session[:user_email] = authorized_user.email
      flash[:notice] = "Nyní jste přihlášen."
      redirect_to(customers_path)
    else
      found_user = Uzivatel.where(:email => params[:email]).first
      if found_user
        flash[:notice] = "Nesprávné heslo."
      else
        flash[:notice] = "Nesprávný email."
      end
      redirect_to(:controller=> 'access', :action => 'login')
    end
  end
    
  def logout
    session[:user_id] = nil
    session[:user_email] = nil
    flash[:notice] = "Odhlášen"
    redirect_to(:controller=> 'access', :action => 'login')
  end
end
