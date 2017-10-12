require 'pry'
class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    redirect to '/recipes'
  end

  #Index action and allows the view to access all the posts in the database
  get '/recipes' do
    @recipes = Recipe.all
    erb :index
  end

  #Get request that loads new.rb form to create a new recipe.
  get '/recipes/new' do
    erb :new
  end

  #Create action, responds to post request and creates a new recipe based on params set on form new.rb and saves it to database.
  post '/recipes' do
    recipe = Recipe.create(:name => params[:name], :ingredients => params[:ingredients], :cook_time => params[:cook_time])
    redirect "/recipes/#{recipe.id}"
  end

  get '/recipes/:id' do
    @recipes = Recipe.find_by_id(params[:id])
    erb :show
  end

  #Will load edit.erb page
  get '/recipes/:id/edit' do
    @recipes = Recipe.find_by_id(params[:id])
    erb :edit
  end

  patch '/recipes/:id' do #edit action
    @recipes = Recipe.find_by_id(params[:id])
    @recipes.name = params[:name]
    @recipes.ingredients = params[:ingredients]
    @recipes.cook_time = params[:cook_time]
    @recipes.save

    redirect "/recipes/#{@recipe.id}"
  end

  delete '/recipes/:id/delete' do #delete action
    @recipes = Recipe.find_by_id(params[:id])
    @recipes.delete
  end

end
