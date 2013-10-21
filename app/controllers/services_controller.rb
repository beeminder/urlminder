class ServicesController < ApplicationController

  def create
    omniauth = request.env["omniauth.auth"] 

    service = Service.where(provider: omniauth["provider"], 
                            uid: omniauth["uid"].to_s).first
    if service
      # service already existing in db. sign user in
      sign_in(:user, service.user)
      redirect_to root_url and return
    elsif current_user
      # adding new authentication service to existing user
      service = current_user.services.build
      service.provider  = omniauth["provider"]
      service.uid       = omniauth["uid"]
      service.token     = omniauth["token"]
      service.uname     = omniauth["info"]["nickname"]
      service.save
      respond_to do |format|
        format.html { redirect_to root_url }
        format.json { render json: { message: "Service created" } }
      end
      return
    else
      user = User.new
      user.apply_omniauth(omniauth)

      if user.save
        user.services.each { |s| s.save }
        sign_in(:user, user)
      else
        session[:omniauth] = omniauth.except('extra')
      end
      redirect_to root_url
    end
  end

end