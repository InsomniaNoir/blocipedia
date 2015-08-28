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
    @wiki = Wiki.build( wiki_params )
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
  end

  private

  def wiki_params
    params.require(:wiki).permit(:title, :body, :private)
  end
end
