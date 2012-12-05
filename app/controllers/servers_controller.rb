class ServersController < ApplicationController
  PER_PAGE = 10

  before_filter :has_logged_in
  def index
    redirect_to(:controller => 'subnets', :action => 'list')
  end

  def list
    if params[:id] == nil
      redirect_to(:controller => 'subnets', :action => 'list')
    end
    @subnet = Subnet.find_by_id(params[:id])
    if @subnet
      @servers = @subnet.entries.paginate({:page => params[:page], :per_page => PER_PAGE})
    else
      redirect_to(:controller => 'subnets', :action => 'list')
    end
  end

  def new
    @subnet = Subnet.find(params[:id])
    @server = Entry.new
  end

  def create
    @subnet = Subnet.find(params[:id])
  end
end
