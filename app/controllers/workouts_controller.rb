class WorkoutsController < ApplicationController

  get '/workouts/new' do 
    if !Helpers.is_logged_in?(session)
      redirect '/'
    end

    erb :'workouts/new'
  end

  post '/workouts' do 
    if Helpers.current_user(session).id == Workout.find_by(id: params[:id]).user_id
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

end