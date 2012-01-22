class Ability
  include CanCan::Ability

  def initialize(user)
    alias_action :otheracts, :read, :to => :modify
   user ||= User.new # guest user (not logged in)
        if user.is? :everything
          can :manage, :all
          can :assign_roles, :all
        else
          can :manage, Contract, :act_code => user.actcode.actcode
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
          can :manage, User, :management_id => user.management_id
          can :manage, Contract, :act_code => user.actcode_id
          cannot :destroy, User
        end
  end
  

end

     # can :manage, @contract
      #    #can :manage, @contract
      #   cannot :destroy, Contract
      
      ## controls user edit of account screen