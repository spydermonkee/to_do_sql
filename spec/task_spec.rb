require 'spec_helper'

describe Task do
  describe '.initialize' do
    it 'is initialized with a name and a list ID' do
      task = Task.new('learn SQL', 1, 1)
      task.should be_an_instance_of Task
    end
  end

  describe '.create' do
    it 'creates a Task with a name and a list ID' do
      task = Task.create('call my friends', 1, 1)
      task.name.should eq 'call my friends'
    end
  end

  describe '#name' do
    it 'tells you its name' do
      task = Task.new('learn SQL', 1, 1)
      task.name.should eq 'learn SQL'
    end
  end

  describe '#list_id' do
    it 'tells you the list ID the task belongs to/ or belongs to the task - however you see it personally' do
      task = Task.new('learn SQL', 1, 2)
      task.list_id.should eq 1
    end
  end


  describe '.all' do
    it 'starts off with no tasks' do
      Task.all.should eq []
    end
  end

  describe '#delete' do
    it 'lets you delete a task based on its tasks table ID' do
      task1 = Task.create('Hello', 1, 2)
      task2 = Task.create('World', 1, 3)
      task1.delete
      Task.all.length.should eq 1
    end
  end

  describe '#save' do
    it 'lets you save tasks to the database' do
      task = Task.new('learn SQL', 1, 1)
      task.save
      Task.all.should eq [task]
    end
  end

  describe '#==' do
    it 'is the same task if it has the same name' do
      task1 = Task.new('learn SQL', 1, 1)
      task2 = Task.new('learn SQL', 1, 1)
      task1.should eq task2
    end
  end
end
