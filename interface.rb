require 'active_record'
require 'pry'
require './lib/task'
require './lib/list'

ActiveRecord::Base.establish_connection(YAML::load(File.open('./db/config.yml'))["development"])

def welcome
  puts "Welcome to the To Do list!"
  menu
end

def menu
  choice = nil
  until choice == 'e'
    puts "Press 'a' to add a task, 'l' to add a list, 'lt' to list your tasks, or 'd' to mark a task as done."
    puts "Press 'e' to exit."
    choice = gets.chomp
    case choice
    when 'a'
      add_task
    when 'l'
      add_list
    when 'lt'
      list_task
    when 'd'
      mark_done
    when 'e'
      puts "Good-bye!"
    else
      puts "Sorry, that wasn't a valid option."
    end
  end
end

def add_task
  puts "What do you need to do?"
  task_name = gets.chomp
  puts "Which list does this task belong to?"
  List.all.each { |list| puts list.name }
  list_name = gets.chomp
  list_id = List.where(:name => list_name).first['id']
  task = Task.new({:name => task_name, :done => false, :list_id => list_id})
  task.save
  "'#{task_name}' has been added to your To Do list."
end

def add_list
  puts "What is the name of your new list?"
  list_name = gets.chomp
  new_list = List.new({:name => list_name})
  new_list.save
  "'#{list_name}' has been created"
end

def list_task
  puts "Choose the list you need to review"
  List.all.each { |list| puts list.name }
  list_name = gets.chomp
  list_id = List.where(:name => list_name).first['id']
  puts "Items on the #{list_name}"
  Task.where(:list_id => list_id).each { |task| puts task.name }
  # puts "Here is everything you need to do:"
  # Task.not_done.each { |task| puts task.name }
end

def mark_done
  puts "Which of these tasks would you like to mark as done?"
  Task.all.each { |task| puts task.name }

  done_task_name = gets.chomp
  done_task = Task.where({:name => done_task_name}).pop
  done_task.update_attributes({:done => true})
end

welcome

