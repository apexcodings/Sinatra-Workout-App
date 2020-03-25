class WorkoutsController < ApplicationController

  get '/workouts/new' do 


    erb :'workouts/new'
  end

  post '/workouts' do 
    workout = Workout.create(params)
    user = Helpers.current_user(session)
    workout.user = user 
    redirect to "/users/#{user.id}"
  end

end