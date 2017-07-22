class AddReadToReadingProgresses < ActiveRecord::Migration[5.0]
  def change
    add_column :reading_progresses, :read, :boolean
  end
end
