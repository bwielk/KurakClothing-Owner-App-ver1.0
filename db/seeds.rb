require_relative('../models/collection')
require_relative('../models/product')
require('pry')

Product.delete_all()
Collection.delete_all()


fw2015 = Collection.new({
  'name' => 'Fall Winter 2015/2016'
  })

fw2015.add()

ss2016 = Collection.new({
  'name' => 'Spring Summer 2016'
  })

ss2016.add()

fw2016 = Collection.new({
  'name' => 'Fall Winter 2016/2017'
  })

fw2016.add()


product1 = Product.new({
  'name' => '1#2',
  'type' => 'scarf',
  'price' => 50,
  'stock' => 23,
  'url' => 'https://mir-s3-cdn-cf.behance.net/project_modules/fs/8d3a5734273809.56cd02a598d02.jpg',
  'collection_id' => ss2016.id})
product1.add()

product2 = Product.new ({
  'name' => '2#1',
  'type' => 'top',
  'price' => 125,
  'stock' => 12,
  'url' => 'https://mir-s3-cdn-cf.behance.net/project_modules/fs/8ba69c34259197.56ca4bc295bcf.jpg',
  'collection_id' => fw2015.id})
product2.add()

product3 = Product.new ({
  'name' => '5#3',
  'type' => 'scarf',
  'price' => 50,
  'stock' => 13,
  'url' => 'https://mir-s3-cdn-cf.behance.net/project_modules/max_1200/fa41c234358287.56cdbd029edf2.jpg',
  'collection_id' => fw2016.id})

product3.add()





binding.pry