class GamesController < ApplicationController

  get '/games' do
    if logged_in?
    @games = Game.all
    erb :'/games/index'
  else 
    redirect to '/login'
  end 
end

  get '/games/new' do
    if logged_in?
    erb :'/games/new'
  else 
    redirect to '/login'
  end 
end

  post '/games' do
    @game = Game.create(params[:game])
    if !params["owner"]["name"].empty?
      @game.owner = Owner.create(name: params["owner"]["name"])
    end
    @game.save
    redirect "game/#{@game.id}"
  end

  get '/games/:id' do
    @game = Game.find(params[:id])
    @owners = Owner.all
    erb :'/games/show'
  end

  patch '/games/:id' do 
    @game = Game.find(params[:id])
    @game.update(params["game"])
    if !params["owner"]["name"].empty?
      @game.owner = Owner.create(name: params["owner"]["name"])
    end
    @game.save
    redirect to "games/#{@game.id}"
  end

  get '/games/:id/edit' do
    @game = Game.find(params[:id])
    erb :'/games/edit'
  end
end