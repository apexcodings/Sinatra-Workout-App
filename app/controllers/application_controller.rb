require './config/environment'
class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end


  get "/" do
    if Helpers.is_logged_in?(session)
      user = Helpers.current_user(session)
      redirect to "/home"
    end

    erb :welcome
  end

  get '/home' do 
    if Helpers.is_logged_in?(session) 
      @user = Helpers.current_user(session)
    end
    erb :home
  end

end