class List < ActiveRecord::Base

  has_many(:tasks)
  # doing something like this:
  # def tasks
  #   results = DB.exec("SELECT * FROM tasks WHERE list_id = self.id")
  #   results.each
  # end

end
