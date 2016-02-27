class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :articles
  has_many :notifications

  mount_uploader :avatar, AvatarUploader

  validates :name, presence: true

  def role
    if admin?
      Settings.admin.true
    else
      Settings.admin.false
    end
  end
end
