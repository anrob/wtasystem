class User < ActiveRecord::Base
  belongs_to :management
  has_many :contracts
  
  devise :database_authenticatable, 
         :recoverable, :rememberable, :trackable, :validatable, :timeoutable
  scope :getotheracts, lambda { |user| where("management_id = ?", user.management_id)}
  ROLES = %w[everything money manager chart]
  attr_accessible :email, :password, :password_confirmation, :remember_me, :actcode, :management_id, :manager, :roles, :first_name, :last_name, :phone_number
 
   def roles=(roles)
     self.roles_mask = (roles & ROLES).map { |r| 2**ROLES.index(r) }.sum
   end

   def roles
     ROLES.reject do |r|
       ((roles_mask || 0) & 2**ROLES.index(r)).zero?
     end
   end
   
   def is?(role)
      roles.include?(role.to_s)
    end

  
  def get_user
      @current_user = current_user
  end
  def fullname
     "#{first_name} #{last_name}"
   end
end
