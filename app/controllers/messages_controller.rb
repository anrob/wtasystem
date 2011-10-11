class MessagesController < InheritedResources::Base
   load_and_authorize_resource 
   respond_to :html, :xml, :json
 
  def index
    @user = current_user
    @pd = @user
  end
  
  def new
    @user = current_user
    @pd = @user
  end
  
  def edit
    @user = current_user
    @pd = @user
  end
  
  def show
     @user = current_user
     @pd = @user
   end
  
  def destroy
    @user = current_user
    @pd = @user
  end
end
