class UsersController < ApplicationController

  get '/signup' do 
    erb :'users/signup'
  end

  post '/users' do 
    user = User.create(params)
    session[:user_id] = user.id 

    redirect to "/users/#{user.id}"
  end

  get '/users/:id' do
    if User.find_by(id: params[:id])
    @user = User.find_by(id: params[:id])
    else 
      redirect to '/'
    end 
    erb :'users/show'
  end

 

end