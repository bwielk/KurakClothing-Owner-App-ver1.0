require('sinatra')
require('sinatra/contrib/all')
require_relative('../models/collection')
require('pry')

#############--COLLECTIONS--######################################


#SHOW COLLECTIONS BY SEASONS 
get '/collection/collection_id/season' do
  @collection = Collection.find(params[:collection_id])
  erb(:"/store/season")
end

#CREATE A NEW COLLECTION
post '/collection' do
  @collection_new = Collection.new(params)
  @collection_new.add
  erb(:"/store/create_new_col")
end

#DESTROY A COLLECTION FORM
get '/collection/id/delete' do # id in the form !!!
  @collection = Collection.find(params[:id])
  erb(:"/store/destroy_col")
end

#DESTROY A COLLECTION
post '/collection/:id/delete' do # id here!!!
  Collection.delete(params[:id])
  redirect to ('/store')
end
