require 'pry'

class UsersController < ApplicationController

  get '/users' do 
    if Helpers.is_logged_in?(session)
    @users = User.all 
    else 
      redirect to '/home'
    end 

    erb :'users/index'
  end

  get '/profile' do 
    if Helpers.is_logged_in?(session)
      @user = Helpers.current_user(session)
    end
    erb :'users/profile'
  end

  post '/login' do 
    user = User.find_by(username: params[:username])

    if user  && user.authenticate(params[:password])
      session[:user_id] = user.id 
      redirect to '/home'
    else 
      flash[:danger] = "You need to have an account to Log In"
      redirect to '/'
    end
  end

  post '/users' do 
    user = User.create(params)
    if user.valid? 
    session[:user_id] = user.id 
    flash[:success] = "You have succesfully created an account!"
    redirect to "/users/#{user.id}"
    else 
      redirect to '/'
    end 
  end

  get '/users/:id' do
    if Helpers.is_logged_in?(session) && User.find_by(id: params[:id])
    @user = User.find_by(id: params[:id])
    @workouts = @user.workouts
    else 
      redirect to '/'
    end 
    erb :'users/show'
  end

  get '/logout' do 
    session.clear 
    redirect to '/'
  end

  get '/users/:id/edit' do
    @user = User.find_by(id: params[:id]) 
    if !Helpers.is_logged_in?(session) || !@user || @user != Helpers.current_user(session) 
      redirect '/'
    end
    erb :'/users/edit'
  end

  patch '/users/:id' do 
    user = User.find_by(id: params[:id])
    if user == Helpers.current_user(session) 
      user.update(params[:user])
      redirect to "/profile"
    else 
      redirect to "/users"
    end 
  end

  delete '/profile' do 
    user = User.find_by(id: params[:id])
    if user == Helpers.current_user(session) 
      user.destroy 
      session.clear
      flash[:success] = "You have succesfully deleted your account!"
    end
    redirect to '/'
  end

end