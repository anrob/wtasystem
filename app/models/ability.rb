class Ability
  include CanCan::Ability

  def initialize(user)
    alias_action :otheracts, :read, :to => :modify
   user ||= User.new # guest user (not logged in)
        if user.is? :everything
          can :manage, :all
          can :assign_roles, :all
        else
          can :read, Contract
          can :update, User, :id => user.id
        end
        
        if user.is? :money
          can :see_money, :all
        end
        
        if user.is? :chart
          can :see_chart, :all
        end
        
        if user.is? :manager
          can :see_others, :all 
          
          can :modify, Contract
        end
  end
end
