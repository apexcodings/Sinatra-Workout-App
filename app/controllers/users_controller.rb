class UsersController < ApplicationController

  get '/signup' do 
    erb :'users/signup'
  end

  post '/users' do 
    user = User.create(params)

    redirect to "/users/#{user.id}"
  end

  get '/users/:id' do
    @user = User.find_by(id: params[:id])

    erb :show
  end

 

end