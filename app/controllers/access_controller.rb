class AccessController < ApplicationController

  before_filter :has_logged_in, :except => [:login, :logout, :do_login]
  def login
    # login form
  end

  def do_login
    logged_in_user = User.authenticate(params[:username], params[:password])

    if logged_in_user
      if !logged_in_user.viewer && !logged_in_user.editor
          flash[:notice] = I18n.t('account_disabled')
          redirect_to(:action => 'login')
        else
        session[:user_id] = logged_in_user.id
        session[:user_username] = logged_in_user.username
        session[:user_password] = logged_in_user.password
        session[:user_name] = logged_in_user.name.blank? ? logged_in_user.username : logged_in_user.name

        flash[:info] = I18n.t('logged_in_successfully')
        redirect_to(:controller => 'subnets', :action => 'list')
      end
    #redirect_to(:action => 'login')
    else
      if session[:failed_logins] == nil
        session[:failed_logins] = 0
      end
      session[:failed_logins] += 1
      flash[:notice] = I18n.t('wrong_username_or_password') #+ " (" + session[:failed_logins].to_s + ")"
      redirect_to(:action => 'login')
    end
  end

  def logout
    session[:failed_logins] = nil
    session[:user_id] = nil
    session[:user_username] = nil
    session[:user_password] = nil
    session[:user_name] = nil
    session[:failed_logins] = nil

    flash[:info] = I18n.t('logged_out_successfully')

    render('login')
  end
end
