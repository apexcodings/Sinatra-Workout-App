class UsersController < ApplicationController

  get '/signup' do 
    erb :'users/signup'
  end

  post '/users' do 
    user = User.create(params)
    if user.valid? 
    session[:user_id] = user.id 
    redirect to "/users/#{user.id}"
    else 
      redirect to 'signup'
    end 
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