class OwnersController < ApplicationController

  get '/owners/:slug' do
    @owner = Owner.find_by_slug(params[:slug])
    erb :'/owners/show'
  end

  get '/owners/new' do 
    @games = Game.all
    erb :'/owners/new'
  end

  post '/owners' do 
    @owner = Owner.create(params[:owner])
  
    if !params["game"]["name"].empty?
      @owner.games << Game.create(name: params["game"]["name"])
    end
    redirect to "owners/#{@owner.id}"
   end

  get '/owners/:id/edit' do
    @owner = Owner.find(params[:id])
    @games = Game.all
    erb :'/owners/edit'
  end

  get '/owners/:id' do 
    @owner = Owner.find(params[:id])
    erb :'/owners/show'
  end

  patch '/owners/:id' do
   
    if !params[:owner].keys.include?("game_ids")
    params[:owner]["pet_ids"] = []
    end
 
    @owner = Owner.find(params[:id])
    @owner.update(params["owner"])
    if !params["game"]["name"].empty?
      @owner.games << Game.create(name: params["game"]["name"])
    end
    redirect to "owners/#{@owner.id}"
end
  end