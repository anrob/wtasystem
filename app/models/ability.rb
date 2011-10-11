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
          #can :manage, :all
          can :see_money, :all
        end
        
        if user.is? :manager
          can :see_others, :all
          can :modify, Contract
          #cannot :update, Contract
        end
        
        #can :manage, :all if user.is? :admin
    #
    # The first argument to `can` is the action you are giving the user permission to do.
    # If you pass :manage it will apply to every action. Other common actions here are
    # :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. If you pass
    # :all it will apply to every resource. Otherwise pass a Ruby class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
