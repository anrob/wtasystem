# -*- encoding : utf-8 -*-
class Ability
  include CanCan::Ability

  def initialize(user)
    alias_action otheracts: :read, to: :modify

   user ||= User.new # guest user (not logged in)
        if user.is? :everything
          can :manage, :all
          can :assign_roles, :all
          can :create,  :all
          can :update, :all
        else
          can :manage, Contract, act_code: user.actcode_name
          #can :manage, User, :manager_id => user.id
        #cannot :manage, User, :self_managed => true
        can :manage, User, :id => user.id
        end

        if user.is? :money
          can :see_money, :all
        end

         if user.is? :no_money
          can :see_no_money, :all
         end

        if user.is? :chart
          can :see_chart, :all
        end

        if user.is? :manager
          can :see_others, :all
          can :assign_roles, User
          can :manage, User, management_id: user.management_id
          can :manage, Contract, act_code: user.actcode_name
          can :manage, Contract
          cannot :destroy, User
        end
  end


end

