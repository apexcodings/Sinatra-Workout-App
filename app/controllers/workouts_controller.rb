class WorkoutsController < ApplicationController


  get '/workouts' do 
    @workouts = Workout.all 

    erb :'workouts/index'
  end

  get '/workouts/new' do 
    if !Helpers.is_logged_in?(session)
      redirect '/'
    end

    erb :'workouts/new'
  end

  post '/workouts' do 
    workout = Workout.create(params)
    user = Helpers.current_user(session)
    workout.user = user 
    workout.save 
    redirect to "/users/#{user.id}"
  end

  get '/workouts/:id' do 
    if !Helpers.is_logged_in?(session)
      redirect '/'
    end
    @workout = Workout.find_by(id: params[:id])
    if !@workout
      redirect to '/'
    end

    erb :'workouts/show'
  end

  get '/workouts/:id/edit' do
    @workout = Workout.find_by(id: params[:id]) 
    if !Helpers.is_logged_in?(session) || !@workout || @workout.user != Helpers.current_user(session) 
      redirect '/'
    end
    erb :'/workouts/edit'
  end

  patch '/workouts/:id' do 
    workout = Workout.find_by(id: params[:id])
    if workout && workout.user == Helpers.current_user(session) 
      workout.update(params[:workout])
      redirect to "/workouts/#{workout.id}"
    else 
      redirect to "/workouts"
    end 
  end

  delete '/workouts/:id/delete' do 
    workout = Workout.find_by(id: params[:id])
    if workout && workout.user == Helpers.current_user(session) 
      workout.destroy 
    end
    redirect to '/workouts'
  end

end