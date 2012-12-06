class SubnetsController < ApplicationController
  PER_PAGE = 10

  before_filter :has_logged_in
  def index
    list
    render('list')
  end

  def new
    # display the new subnet form
    @subnet = Subnet.new
  end

  def create
    @subnet = Subnet.new(params[:subnet])
    user = recheck_logged_in_user
    if is_editor
      @subnet.author = user
      if @subnet.save
        flash[:info] = t(:saved_successfully)
        redirect_to(:action => 'list')
      else
        render('new')
      end
    else
      flash[:notice] = I18n.t('you_do_not_have_edit_privilege')
      render('new')
    end
  end

  def update
    @subnet = Subnet.find(params[:id])
    user = recheck_logged_in_user
    if is_editor
      @subnet.author = user
      if @subnet.update_attributes(params[:subnet])
        flash[:info] = t(:saved_successfully)
        redirect_to(:action => 'list')
      else
        render('edit')
      end
    else
      flash[:notice] = I18n.t('you_do_not_have_edit_privilege')
      render('edit')
    end
  end

  def list
    @subnets = Subnet.paginate({:page => params[:page], :per_page => PER_PAGE})
  end

  def show
    if params[:id] == nil
      redirect_to('/')
    else
      @subnet = Subnet.find(params[:id])
    end
  end

  def edit
    @subnet = Subnet.find(params[:id])
  end

  def delete
    @subnet = Subnet.find(params[:id])
  end

  def destroy
    @subnet = Subnet.find(params[:id])
    user = recheck_logged_in_user
    if is_editor
      @subnet.destroy
      flash[:info] = t(:deleted_successfully)
      redirect_to(:action => 'list')
    else
      flash[:notice] = t(:you_do_not_have_edit_privilege)
      render('delete')
    end
  end
end
