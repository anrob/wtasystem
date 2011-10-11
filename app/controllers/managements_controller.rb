class ManagementsController < InheritedResources::Base
#inherit_resources
load_and_authorize_resource #:management, :through => :contract

 respond_to :html, :xml, :json
#  def index
#      if can? :everything, @contract
#      @user = current_user
#      @pd = @user
#    else
#      redirect_to :root
#    end
#  end
# 
# def new
#    @user = current_user
#   @pd = @user
# end
# 
# def show
#    @user = current_user
#   @pd = @user
# end
# 
# def edit
#    @user = current_user
#   @pd = @user
# end

end
