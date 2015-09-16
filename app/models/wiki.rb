class Wiki < ActiveRecord::Base
  belongs_to :user
  has_many :users, through: :collaborators
  has_many :collaborators

  default_scope { order('created_at DESC')}

  validates :title, presence: true
  validates :body, presence: true
  validates :user, presence: true

  def all_collaborators
    names = []
    collaborators.each do |collaborator|
      names << collaborator.user.name || collaborator.user.email
    end
      names
  end
end
