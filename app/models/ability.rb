class Ability
  include CanCan::Ability

  def initialize(user)
    alias_action :otheracts, :read, :to => :modify
   user ||= User.new # guest user (not logged in)
        if user.is? :everything
          can :manage, :all
          can :assign_roles, :all
          # can :update, User
        else
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
          
          #can :modify, @contract
        end
  end
end

     # can :manage, @contract
      #    #can :manage, @contract
      #   cannot :destroy, Contract
      
      ## controls user edit of account screen