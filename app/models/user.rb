# -*- encoding : utf-8 -*-
class User < ActiveRecord::Base
  belongs_to :management
  #belongs_to :actcode
  #has_many :contracts
  alias_attribute "name", "email"
  validates_uniqueness_of :actcode_name, on: :create, message: "must be unique"
 # accepts_nested_attributes_for :actcode
  default_scope order: 'email ASC'
  devise :database_authenticatable,:recoverable, :rememberable, :trackable, :timeoutable, :registerable, :confirmable
         #scope :mystuff, lambda { |user| where("actcode = ?", user.act_code)}
         #scope :unconfirmedevent, lambda { |contract|  where(confirmation: 0)}
        # scope :ismanager, where(if user.role == "manager")

  scope :getotheracts, lambda { |user| where("management_id = ?", user.management_id)}
  scope :with_role, lambda { |role| {conditions: "roles_mask & #{2**ROLES.index(role.to_s)} > 0"} }
  scope :notconfirmed, where(confirmed_at: nil)
  ROLES = %w[everything gross manager no_money]
  attr_accessible :email, :password, :password_confirmation, :remember_me, :management_id, :manager, :roles, :first_name, :last_name, :phone_number, :actcode_name, :encrypted_password

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

    def accessible_roles
      @accessible_roles = Role.accessible_by(current_ability,:read)
    end

  def fullname
     "#{first_name} #{last_name}"
   end

   def attempt_set_password(params)
     p = {}
     p[:password] = params[:password]
     p[:password_confirmation] = params[:password_confirmation]
     update_attributes(p)
   end
   # new function to return whether a password has been set
   def has_no_password?
     self.encrypted_password.blank?
   end

   # new function to provide access to protected method unless_confirmed
   def only_if_unconfirmed
     unless_confirmed {yield}
   end


end
