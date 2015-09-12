class CollaboratorController < ApplicationController
  def index
    @collaborators = Collaborators.all
  end
end
