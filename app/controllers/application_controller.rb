lass ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    @recipes=Recipe.all
    erb :index
  end

  get '/recipes/new' do
    erb :new
  end

  post '/recipes' do
    @recipe=Recipe.create(name:@params[:name],ingredients:@params[:ingredients],cook_time:@params[:cook_time])
    route="/recipes/#{@recipe.id}"
    redirect(route)
  end

  get '/recipes' do
    @recipes=Recipe.all
    erb :index
  end

  get '/recipes/:id' do
    @recipe=Recipe.find_by_id(@params[:id])
    erb :show
  end

  get '/recipes/:id/edit' do
    @recipe=Recipe.find_by_id(@params[:id])
    erb :edit
  end

  patch '/recipes/:id/edit' do
    @recipe=Recipe.find_by_id(@params[:id])
    @recipe.name=@params[:name]
    @recipe.ingredients=@params[:ingredients]
    @recipe.cook_time=@params[:cook_time]
    @recipe.save
    route="/recipes/#{@recipe.id}"
    redirect(route)
  end

  delete "/recipes/:id/delete" do
    @recipe=Recipe.find_by_id(@params[:id])
    @recipe.delete
    redirect("/")
  end


end
