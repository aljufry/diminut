class ServersController < ApplicationController
  PER_PAGE = 10

  before_filter :has_logged_in
  
  def index
    redirect_to(:controller => 'subnets', :action => 'list')
  end

  def list
    if params[:id] == nil
      redirect_to(:controller => 'subnets', :action => 'list')
    else
      @subnet = Subnet.find_by_id(params[:id])
      if @subnet
        @servers = @subnet.entries.paginate({:page => params[:page], :per_page => PER_PAGE})
      else
        redirect_to(:controller => 'subnets', :action => 'list')
      end
    end
  end

  def new
    @subnet = Subnet.find(params[:id])
    @server = Entry.new
  end
  
  def show
    if params[:id] == nil
      redirect_to('/')
    else
      @server = Entry.find(params[:id])
    end    
  end
  
  def delete
    @server = Entry.find(params[:id])
  end

  def destroy
    @server = Entry.find(params[:id])
    subnet = @server.subnet
    user = recheck_logged_in_user
    if is_editor
      @server.destroy
      flash[:info] = t(:deleted_successfully)
      redirect_to(:action => 'list', :id => subnet.id)
    else
      flash[:notice] = t(:you_do_not_have_edit_privilege)
      render('delete')
    end
  end

  def edit
    @server = Entry.find(params[:id])
    @subnet = @server.subnet
  end

  def update
    @server = Entry.find(params[:id])
    subnet = @server.subnet
    user = recheck_logged_in_user
    if is_editor
      @server.author = user
      if @server.update_attributes(params[:server])
        flash[:info] = t(:saved_successfully)
        redirect_to(:action => 'list', :id => subnet.id)
      else
        render('edit')
      end
    else
      flash[:notice] = t(:you_do_not_have_edit_privilege)
      render('edit')
    end
  end

  def create
    @subnet = Subnet.find(params[:id])
    @server = Entry.new(params[:server])    
    user = recheck_logged_in_user
    if is_editor
      @server.author = user
      @server.subnet = @subnet
      if @server.save
        flash[:info] = t(:saved_successfully)
        redirect_to(:action => 'list', :id => @subnet.id)
      else
        render('new')
      end
    else
      flash[:notice] = t(:you_do_not_have_edit_privilege)
      render('new')
    end
  end
end
