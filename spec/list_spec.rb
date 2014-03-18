require 'spec_helper'

describe List do
  it 'is initialized with a name' do
    list = List.new('Our new List')
    list.should be_an_instance_of List
  end

  it 'can be initialized with its database ID' do
    list = List.new('Cool stuff', 2)
    list.should be_an_instance_of List
  end

  describe '#name' do
    it 'tells you its name' do
      list = List.new('Our new List')
      list.name.should eq 'Our new List'
    end
  end

  describe '#id' do
    it 'tells you its id' do
      list = List.new('this is another list', 4)
      list.save
      list.id.should be_an_instance_of Fixnum
    end
  end

  describe '#==' do
    it 'is the same list if it has the same name' do
      list1 = List.new('A List!')
      list2 = List.new('A List!')
      list1.should eq list2
    end
  end

  describe '.all' do
    it 'starts off with no lists' do
      List.all.should eq []
    end
  end

  describe '#save' do
    it 'lets you save lists with an id to the database' do
      list = List.new('learn SQL')
      list.save
      List.all.should eq [list]
      list.id.should be_an_instance_of Fixnum
    end
  end

  describe '#delete' do
    it 'deletes a list' do
      list1 = List.create('buy gum', 1)
      list2 = List.create('wash llama', 1)
      list1.delete
      List.all.length.should eq 1
    end
  end

end
