class IncomingMailsController < ApplicationController    
  require 'mail'
  skip_before_filter :verify_authenticity_token
  before_filter :skipthelogin

  def create
    message = ContractemailMailer.receiver(Mail.new(params[:message]))
    if !message.new_record?
            render :text => "Success", :status => 201, :content_type => Mime::TEXT.to_s
        else
          render :text => message.errors.full_messages.join(', '), :status => 422, :content_type => Mime::TEXT.to_s
  end
end
end