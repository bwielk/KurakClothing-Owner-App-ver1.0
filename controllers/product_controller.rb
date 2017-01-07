require('sinatra')
require('sinatra/contrib/all')
require_relative('../models/product')
require_relative('../models/collection')
require('pry')

# INDEX
get '/store' do 
  @products = Product.all
  @collections = Collection.all
  erb(:"/store/index")
end


##############--PRODUCT--#########################################

#NEW PRODUCT FORM
get '/store/new' do
  @collections = Collection.all
  erb(:"/store/new")
end
#ERROR 
# get '/store/error'
# erb(:"/store/error")

#NEW PRODUCT CREATED
post '/store/new_product' do 
  @product = Product.new(params)
  # if params.length == 0
  #    redirect to('/store/error') 
  #  else
  @product.add()
  #end
  erb(:"/store/create")
end

#SHOW PRODUCT
get '/store/:id/season' do
  @product = Product.find(params[:id])
  erb(:"/store/show")
end

#EDIT PRODUCT FORM
get '/store/:id/edit' do
  @collections = Collection.all
  @product = Product.find(params[:id])
  erb(:"/store/edit")
end

#UPDATED PRODUCT
post '/store/:id' do 
  @product = Product.update(params)
  redirect to('/store')
end

#SELL PRODUCT
post '/store/:id/sell' do
  @product = Product.find(params[:id])
  @product.sell(params[:quantity])
  erb(:"/store/sell")
end

#DESTROY PRODUCT
post '/store/:id/delete' do
  Product.delete(params[:id])
  redirect to('/store')
end

##################################################################


