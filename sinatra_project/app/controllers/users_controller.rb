class UsersController < ApplicationController

  get '/login'
  if !logged_in?
    erb :'users/login'
  else 
    redirect to '/games'
  end 
end 
  
  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'/users/show'
  end

  get '/users/new' do 
    @games = Game.all
    erb :'/users/new'
  end

  post '/users' do 
    @user = User.create(params[:user])
  
    if !params["game"]["name"].empty?
      @user.games << Game.create(name: params["game"]["name"])
    end
    redirect to "users/#{@user.id}"
   end

  get '/users/:id/edit' do
    @user = User.find(params[:id])
    @games = Game.all
    erb :'/users/edit'
  end

  get '/users/:id' do 
    @user = User.find(params[:id])
    erb :'/users/show'
  end

  patch '/users/:id' do
   
    if !params[:user].keys.include?("game_ids")
    params[:user]["pet_ids"] = []
    end
 
    @user = User.find(params[:id])
    @user.update(params["user"])
    if !params["game"]["name"].empty?
      @user.games << Game.create(name: params["game"]["name"])
    end
    redirect to "users/#{@user.id}"
end
  end
