class LinksController < ApplicationController
  before_action :ensure_logged_in

  def index
    @links = Link.all
  end

  def create
    @link = Link.new(link_params)
    @link.user_id = current_user.id
    if @link.save
      redirect_to link_url(@link)
    else
      flash.now[:errors] = @link.errors.full_messages
      render :new
    end
  end
  
  def new
    @link = Link.new
    render :new
  end

  def edit
    @link = Link.find(params[:id])
  end

  def show
    @link = Link.find(params[:id])
  end

  def update
    @link = current_user.links.find(params[:id])
    if @link.update(link_params)
      redirect_to link_url(@link)
    else
      flash.now[:errors] = @link.errors.full_messages
      redirect_to edit_link_url
    end
  end

  private

  def link_params
    params.require(:link).permit(:title, :url)
  end

end