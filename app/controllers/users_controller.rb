class UsersController < ApplicationController
  PER_PAGE = 10

  before_filter :has_logged_in
  def index
    list
    render('list')
  #redirect_to(:action => "list")
  end

  def list
    @users = User.paginate({:page => params[:page], :per_page => PER_PAGE})
  end

  def edit
    @user = User.find(params[:id])
  end

  def delete
    @user = User.find(params[:id])
  end

  def reset_password
    if is_editor
      @user = User.find(params[:id])
      user = recheck_logged_in_user
      if @user
        new_password = Security.generate_random_string(8)
        @user.plain_password = new_password
        @user.save
        flash[:info] = @user.username + " new password: " + new_password
        if user.id == @user.id
          session[:user_id] = @user.id
          session[:user_username] = @user.username
          session[:user_password] = @user.password
          session[:user_name] = @user.name.blank? ? @user.username : @user.name
        end
      else
        flash[:error] = t(:unknown_error)
      end
    else
      flash[:notice] = t(:you_do_not_have_edit_privilege)
    end
    redirect_to(:action => 'list')
  end

  def new
    @user = User.new
    @user.plain_password = Security.generate_random_string(8)
  end

  def change_name
    @user = recheck_logged_in_user
  end
  
  def update_name
    @user = recheck_logged_in_user
    if @user.update_attributes(params[:user])
      session[:user_name] = @user.name.blank? ? @user.username : @user.name
      flash[:info] = t(:saved_successfully)            
    else
      flash[:error] = t(:unknown_error)
    end
    
    redirect_to(:action => 'change_name')
  end

  def change_password    
    # display the form
  end

  def update_password
    old_password = params[:old_password]
    new_password = params[:new_password]
    confirm_password = params[:confirm_password]

    if old_password.length <= 0
      flash[:notice] = t(:enter_old_password)
    else
      if new_password.length <= 0
        flash[:notice] = t(:enter_new_password)
      else
        logged_in_user = recheck_logged_in_user
        if User.authenticate(logged_in_user.username, old_password)
          if new_password == confirm_password
            logged_in_user.plain_password = new_password
            if logged_in_user.save
              flash[:info] = t(:saved_successfully)
            else
              flash[:error] = t(:unknown_error)
            end
          else
            flash[:notice] = t(:confirm_password_does_not_match)
          end
        else
          flash[:notice] = t(:wrong_old_password)
        end
      end
    end

    redirect_to(:action => 'change_password')
  end

  def create
    @user = User.new(params[:user])
    @user.salt = Security.generate_salt    
    if is_editor      
      if @user.save
        flash[:info] = t(:saved_successfully)
        redirect_to(:action => 'list')
      else
        render('new')
      end
    else
      flash[:notice] = t(:you_do_not_have_edit_privilege)
      render('new')
    end
  end

  def update
    @user = User.find(params[:id])
    if is_editor
      if @user.update_attributes(params[:user])
        flash[:info] = t(:saved_successfully)
        redirect_to(:action => 'list')
      else
        render('edit')
      end
    else
      flash[:notice] = t(:you_do_not_have_edit_privilege)
      render('edit')
    end
  end

  def destroy
    @user = User.find(params[:id])
    if is_editor
      @user.destroy
      flash[:info] = t(:deleted_successfully)
      redirect_to(:action => 'list')
    else
      flash[:notice] = I18n.t('you_do_not_have_edit_privilege')
      render('delete')
    end
  end
end
