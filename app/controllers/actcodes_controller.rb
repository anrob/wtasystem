class ActcodesController < BaseController
inherit_resources
load_and_authorize_resource

def index
  #@actcodes = Actcode.paginate(:page => params[:page], :per_page => 30)
   @search = Actcode.search(params[:search])
   @actcodes = @search.paginate(:page => params[:page])  # load all matching records
end
end