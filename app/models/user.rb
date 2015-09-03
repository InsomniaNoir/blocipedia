class User < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :wikis
  after_initialize :set_default_role

  def standard?
    role == 'standard'
  end

  def admin?
    role == 'admin'
  end

  def premium?
    role == 'premium'
  end

  def set_default_role
    self.role ||= 'standard'
  end

  def upgrade_account(user)
    user.role = 'standard'
    user.save
    user.wikis.where(private: true).update_all(private: false)
  end
end
