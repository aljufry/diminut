class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :set_locale
  #before_filter :has_logged_in
  def self.year
    @@year = Date.today.year
    return @@year
  end

  protected

  def has_logged_in
    if session[:user_id]
    return true
    else
      flash[:notice] = I18n.t('you_have_not_logged_in')
      redirect_to(:controller => 'access', :action => 'login')
    return false
    end
  end

  def recheck_logged_in_user
    user = User.find_by_username(session[:user_username])
    if user != nil
      if user.username == session[:user_username] && user.password == session[:user_password]
      return user
      end
    end
    return false
  end

  def is_editor
    if session[:user_id]
      user = recheck_logged_in_user
    return user && user.editor
    end
  end

  def set_locale
    I18n.locale = params[:lang] if params[:lang].present?
  end
end
