class RemoveReadFromReadingProgresses < ActiveRecord::Migration[5.0]
  def change
    remove_column :reading_progresses, :read
  end
end
