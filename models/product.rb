require_relative('../db/sql_runner')
require_relative('collection')

class Product

  attr_accessor :name, :type, :stock, :price, :url, :collection_id
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i unless options['id'].nil?
    @name = options['name']
    @type = options['type']
    @price = options['price'].to_i
    @stock = options['stock'].to_i
    #@order_amount = options['order_amount'].to_i
    @url = options['url']
    @collection_id = options['collection_id'].to_i
  end

  def add()
    sql = "INSERT INTO products (name, type, price, stock, url, collection_id) VALUES ('#{@name}','#{@type}', #{@price}, #{@stock}, '#{@url}', #{@collection_id}) RETURNING *;"
    result = SqlRunner.run(sql)
    @id = result[0]['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM products;"
    result = SqlRunner.run(sql)
    return result.map {|element| Product.new(element)}
  end

  def update_price(new_price)
    sql = "UPDATE products SET price =#{new_price} WHERE id = #{@id}"
    SqlRunner.run(sql)
  end

  def self.find(id)
    sql = "SELECT * FROM products WHERE id = #{id};"
    product = SqlRunner.run(sql)
    result = product.map{|element| Product.new(element)}
    return result[0]
  end

  def self.update(options)
    sql = "UPDATE products SET
    name='#{options['name']}',
    type='#{options['type']}',
    price=#{options['price']},
    stock=#{options['stock']},
    url='#{options['url']}',
    collection_id=#{options['collection_id']} WHERE id=#{options['id']};"
    SqlRunner.run( sql )
  end
  
  def update_name(new_name)
    sql = "UPDATE products SET name = '#{new_name}' WHERE id = #{@id};"
    SqlRunner.run(sql)
  end

  def update_type(new_type)
    sql = "UPDATE products SET type = '#{new_type}' WHERE id = #{@id};"
    SqlRunner.run(sql)
  end

  def update_stock(new_stock)
    sql = "UPDATE products SET stock = #{new_stock} WHERE id = #{@id};"
    SqlRunner.run(sql)
  end

  def update_url(new_url)
    sql = "UPDATE products SET url = '#{new_url}' WHERE id = #{@id};"
    SqlRunner.run(sql)
  end

  def delete()
    sql = "DELETE FROM products WHERE id = #{@id};"
    SqlRunner.run(sql)
  end

  def self.delete(id)
    sql = "DELETE FROM products WHERE id = #{id};"
    SqlRunner.run(sql)
  end

  def self.delete_all
    sql = "DELETE FROM products;"
    SqlRunner.run(sql)
  end

  def stock_level()
    if @stock <= 10 && @stock != 0
      return "LOW"
    elsif @stock > 10 && @stock < 20
      return "MEDIUM"
    elsif @stock >= 20
      return "HIGH"
    elsif @stock == 0
      return "OUT OF STOCK. ORDER MORE"
    end
  end

  # def place_order(amount)
  #   order_am = @order_amount + amount
  #   update_order(order_am)
  # end 

  # def receive_order
  #   result = @order_amount
  #   new_stock = @stock + result.to_i
  #   update_stock(new_stock)
  # end

  # def delete_order
  #   sql = "DELETE order_amount FROM products WHERE id = #{@id};"
  #   SqlRunner.run(sql)
  # end

  # def update_order(new_amount)
  #   sql = "UPDATE products SET order_amount = #{new_amount} WHERE id = #{@id};"
  #   SqlRunner.run(sql)
  # end
  
  def sell(number)
    if @stock >=1 && number.to_i <= @stock
      new_stock = @stock - number.to_i
      update_stock(new_stock.to_i)
        if number.to_i == 1
      return "You have sold 1 item"
        elsif number.to_i >1
      return "You have sold #{number} items"
        end
    elsif number.to_i > @stock
      return "NOT ENOUGH PIECES IN STOCK. ORDER MORE! NO DEAL!"
    elsif number.to_i == 0
      return "OUT OF STOCK! NO DEAL!"
    end
  end

  def show_collection
    sql = "SELECT * FROM collections WHERE id = #{@collection_id};"
    result = SqlRunner.run(sql)
    return result.map {|element| Collection.new(element)}
  end

  def show_collection_name
    sql = "SELECT * FROM collections WHERE id = #{@collection_id};"
    result = SqlRunner.run(sql)
    return result[0]['name']
  end
end