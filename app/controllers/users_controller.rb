require 'pry'

class UsersController < ApplicationController
  
   get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'/users/show'
  end
  
  get '/signup' do
    if !logged_in?
      erb :'/users/signup'
    else 
      redirect to '/games'
    end
  end

  post '/signup' do
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      redirect to '/signup'
    else
      @user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
      @user.save
      session[:user_id] = @user.id
      redirect to '/games'
    end
  end

  get '/login' do
    if !logged_in?
      erb :'users/login' 
    else
      redirect to '/games'
    end
  end

  post '/login' do
    user = User.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect to "/games"
    else
      redirect to '/failure'
    end
  end

  get '/failure' do 
    erb :'/users/failure'
  end 
  
  get '/logout' do
    if logged_in?
      session.clear
      redirect to '/' 
    else 
      redirect to '/login'
    end 
  end
end


