class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable, :timeoutable

  validates :username, format: { with: /\A[a-z0-9][-_a-z0-9]{1,19}\z/i }
end
