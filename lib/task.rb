require 'pg'

class Task

  attr_reader :name, :list_id, :id

  def initialize(name, list_id, id=nil)
    @name = name
    @list_id = list_id
    @id = id
  end

  def self.create(name, list_id, id)
    task = Task.new(name, list_id, id)
    task.save
    task
  end

  def self.all
    results = DB.exec("SELECT * FROM tasks;")
    tasks = []
    results.each do |result|
      name = result['name']
      list_id = result['list_id'].to_i
      id = result['id'].to_i
      tasks << Task.new(name, list_id, id)
    end
    tasks
  end

  def delete
    DB.exec("DELETE FROM tasks WHERE id = #{@id};")
  end

  def save
    results = DB.exec("INSERT INTO tasks (name, list_id) VALUES ('#{@name}', #{@list_id}) RETURNING id;")
    @id = results.first['id'].to_i
  end

  def ==(another_task)
    (self.name == another_task.name && self.list_id == another_task.list_id) && self.id == another_task.id
  end


end
