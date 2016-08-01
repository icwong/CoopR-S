require 'digest'

class AuthenticationsController < ApplicationController

  def help
  end

  def success
  end

  def fail
  end

	def mail
		@me = current_user
		@sid = hash( @me.id )
    @auth = Authentication.find_by user_id: current_user.id

    if (!@me.email.include? "@ubc.ca") && 
       (!@me.email.include? "@sfu.ca") && 
       (!@me.email.include? "@myLangara.bc.ca")
      redirect_to fail_path
      flash[:notice] = 'Your email is not issued by a BC university/college.' 
      return
    end

    if @auth.nil?
      @auth = Authentication.new( {:user_id => @me.id, :serial => @sid} )
      @auth.save
    else
      @auth.update( {:serial => @sid} )
    end

  	VerifyMailer.send_mail( @me, @sid ).deliver
  	redirect_to auth_path
    flash[:notice] = 'Email has been sent.' 
  end

  	def verify
      @auth = Authentication.find_by user_id: current_user.id
      if @auth.nil?
        redirect_to root_path
        flash[:notice] = 'You did not apply anything'
      else
        @sid = params[:sid]
        if @sid == @auth.serial
          @auth.update( {:pass => true, :serial => nil} )
          redirect_to success_path
        else
          redirect_to fail_path
        end
      end
  	end

	private
  	def hash( rawID )
  		return Digest::SHA256.hexdigest (rawID.to_s + Time.now.to_i.to_s ) 
  	end

    def clean_up
      Authentication.delete_all
    end
end
