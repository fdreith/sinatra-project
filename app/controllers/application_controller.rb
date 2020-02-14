require './config/environment'


class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    register Sinatra::Flash
    set :session_secret, "secret"
  end

  get "/" do
    if logged_in?
      redirect to '/home'
    else
      redirect to '/login'
    end
  end

  def logged_in?
    !!current_user
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) 
  end

  def redirect_if_not_logged_in
    if !logged_in?
      redirect '/'
    end
  end

end
