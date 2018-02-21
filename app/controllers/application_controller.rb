
class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
  end

  get '/recipes/new' do
    erb :new
  end

  post '/recipes' do
    Recipe.create(name: params[:name], ingredients: params[:ingredients], cook_time: params[:cook_time])
    redirect to "/recipes/#{Recipe.last.id}"
  end

  get '/recipes' do
    erb :index
  end

  get '/recipes/:id/edit' do
    @recipe = Recipe.find(params[:id])
    erb :edit
  end

  #why does post work but not patch?
  patch '/recipes/:id' do
    recipe = Recipe.find(params[:id])
    @recipe = recipe.update(name: params[:name], ingredients: params[:ingredients], cook_time: params[:cook_time])
    # binding.pry
    redirect "/recipes/#{recipe.id}"
  end

  get '/recipes/:id' do
    @recipe = Recipe.find(params[:id])
    erb :show
    # binding.pry
  end

  delete '/recipes/:id' do
    recipe = Recipe.find(params[:id])
    recipe.destroy
    # erb :index
  end
end
