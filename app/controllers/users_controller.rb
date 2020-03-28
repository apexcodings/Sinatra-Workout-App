class UsersController < ApplicationController

  get '/users' do 
    if Helpers.is_logged_in?(session)
    @users = User.all 
    else 
      redirect to '/'
    end 

    erb :'users/index'
  end

  get '/profile' do 
    if Helpers.is_logged_in?(session)
      @user = Helpers.current_user(session)
    end
    erb :'users/profile'
  end

  get '/signup' do 
    if Helpers.is_logged_in?(session) 
      user = Helpers.current_user(session)
      redirect to "/users/#{user.id}"
    end
    erb :'users/signup'
  end

  get '/login' do 
    if Helpers.is_logged_in?(session) 
      user = Helpers.current_user(session)
      redirect to "/users/#{user.id}"
    end
    erb :'users/login'
  end

  post '/login' do 
    user = User.find_by(username: params[:username])

    if user  && user.authenticate(params[:password])
      session[:user_id] = user.id 
      redirect to "/users/#{user.id}"
    else 
      redirect to '/signup'
    #  flash[:error] = "You need to be logged in!"
    end
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

  get 'users/:id/edit' do
    @workout = Workout.find_by(id: params[:id]) 
    if !Helpers.is_logged_in?(session) || !@workout || @workout.user != Helpers.current_user(session) 
      redirect '/'
    end
    erb :'/workouts/edit'
  end

  patch '/users/:id' do 
    workout = Workout.find_by(id: params[:id])
    if workout && workout.user == Helpers.current_user(session) 
      workout.update(params[:workout])
      redirect to "/workouts/#{workout.id}"
    else 
      redirect to "/workouts"
    end 
  end

  delete '/users/:id/delete' do 
    workout = Workout.find_by(id: params[:id])
    if workout && workout.user == Helpers.current_user(session) 
      workout.destroy 
    end
    redirect to '/workouts'
  end

end