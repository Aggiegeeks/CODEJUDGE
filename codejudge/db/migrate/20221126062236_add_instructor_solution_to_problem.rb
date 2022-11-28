class AddInstructorSolutionToProblem < ActiveRecord::Migration[7.0]
  def change
    add_column :problems, :instructor_solution, :text
  end
end
