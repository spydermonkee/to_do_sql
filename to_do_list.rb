require 'pg'
require './lib/task'
require './lib/list'

DB = PG.connect({:dbname => 'to_do'})

def welcome
  puts "Welcome to the To Do list!"
  menu
end

def menu
  puts "Press 'n' to create a new list"
  puts "Press 'l' to list all lists"
  puts "Press 'q' to quit"

  choice = gets.chomp

  case choice
  when 'n'
    puts "Please enter a name for your new list: "
    new_list = List.create(gets.chomp,1)
    menu
  when 'l'
    lists = List.all
    lists.each_with_index do |list, index|
      puts "#{index+1}. #{list.name}"
    end
    list_menu
  when 'q'
    exit
  else
    puts "That is not a valid option."
    menu
  end
end

def list_menu
  puts "Enter a list's number to view or edit that list's tasks."
  puts "Press 'd' to delete a list."
  puts "Press 'm' to return to main menu"
  choice = gets.chomp
  if choice == 'm'
    menu
  elsif choice == 'd'
    puts "Please enter the ID of the list you'd like to delete"
    puts "Or enter 'lm' to return to list menu"
    list_id = gets.chomp
    if list_id == 'lm'
      list_menu
    elsif list_id.to_i <= List.all.length
      this_list = List.all[list_id.to_i-1]
      this_list.delete
      puts "#{this_list.name} has been deleted."
      list_menu
    else
      puts "That is not a valid input."
      list_menu
    end
  elsif choice == /\d/
    task_menu
  else
    puts "That is not a valid option."
  end
end

def task_menu
end

welcome
