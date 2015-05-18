class AddIndexToCourseName < ActiveRecord::Migration
  def change
    add_index "courses", ["name"], name: "index_courses_on_name", :unique => true
  end
end
