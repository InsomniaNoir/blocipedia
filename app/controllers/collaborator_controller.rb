class CollaboratorController < ApplicationController
  def index
    @collaborators = Collaborators.all
  end

  def show
    @collaborator = Collaborator.find(params[:id])
  end
end
