class AddCalorieToJobs < ActiveRecord::Migration[5.0]
  def change
    add_column :jobs, :calorie, :integer
  end
end
