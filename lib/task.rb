class Task < ActiveRecord::Base

  belongs_to(:list)
  # doing something like this:
  # def list
  #   result = DB.exec("SELECT * FROM lists WHERE id = self.list_id").first
  #   List.new(result)
  # end

  def self.not_done
    where({:done => false})
  end


end
