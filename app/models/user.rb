class User < ActiveRecord::Base
  enum role: [:user, :admin, :premium]
  after_initialize :set_default_role

  def set_default_role
    role ||= :user
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :wikis

  def admin?
    role == 'admin'
  end

  def premium?
    role == 'premium'
  end
end
