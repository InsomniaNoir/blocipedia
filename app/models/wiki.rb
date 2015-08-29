class Wiki < ActiveRecord::Base
  belongs_to :user
  after_initialize :defaults

  def defaults
    scope :visible_to, -> (user) { user ? all : where( private: false ) }
  end
end
