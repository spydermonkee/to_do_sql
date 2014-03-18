require 'pg'

class List
  attr_reader :name, :id

  def initialize(name, id=nil)
    @name = name
    @id = id
  end

  def self.create(name, id)
    list = List.new(name, id)
    list.save
    list
  end

  def ==(another_list)
    self.name == another_list.name && self.id == another_list.id
  end

  def self.all
    results = DB.exec("SELECT * FROM lists;")
    lists = []
    results.each do |result|
      name = result['name']
      id = result['id'].to_i
      lists << List.new(name, id)
    end
    lists
  end

  def save
    results = DB.exec("INSERT INTO lists (name) VALUES ('#{@name}') RETURNING id;")
    @id = results.first['id'].to_i
  end

  def delete
    DB.exec("DELETE FROM lists WHERE id = #{@id};")
  end
end
