class WikisController < ApplicationController
  def index
    @wikis = Wiki.all
  end

  def show
    @wiki = Wiki.find(params[:id])
  end

  def new
    @wiki = Wiki.new
  end

  def create
    @wiki = Wiki.new( wiki_params )
    if @wiki.save
      flash[:notice] = "Great success!"
      redirect_to @wiki
    else
      flash[:error] = "Maybe you should take up a new hobby... like knitting!"
      redirect_to :new
    end
  end

  def edit
    @wiki = Wiki.find(params[:id])
  end

  def update
    @wiki = Wiki.find(params[:id])
    if @wiki.update_attributes( wiki_params )
      flash[:notice] = "Great update success!"
    else
      flash[:error] = "You're not very good at this, are you?"
    end
    redirect_to @wiki
  end

  def destroy
    @wiki = Wiki.find(params[:id])

    if @wiki.destroy
      flash[:notice] = "This wiki is no more! It has ceased to be!"
      redirect_to wikis_path
    else
      flash[:error] = "You cannot kill what you did not create!"
      render :show
    end
  end

  private

  def wiki_params
    params.require(:wiki).permit(:title, :body, :private)
  end
end
