class OwnersController < ApplicationController

  get '/owners/:slug' do
    @owner = Owner.find_by_slug(params[:slug])
    erb :'/owners/show'
  end
  
  get '/signup' do 
    if !logged_in?
      erb : '/owners/create_owner'
    else 
      redirect to '/games'
    end 
  end 
  
  post '/signup' do 
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      redirect to '/signup'
    else
      @owner = Owner.new(:username => params[:username], :email => params[:email], :password => params[:password])
      @owner.save
      session[:user_id] = @owner.id
      redirect to '/games'
    end
  end
  
  get '/login' do 
    if !logged_in?
      erb: '/users/login'
    else 
      redirect to '/games'
    end 
  end 
  
  post '/login' do 
    owner = Owner.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect to "/tweets"
    else
      redirect to '/signup'
    end
  end
  
  get '/logout' do 
    if !logged_in
      redirect to '/'
    else 
      session.clear
      redirect to '/login'
    end 
  end 
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