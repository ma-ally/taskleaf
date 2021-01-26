class AddUserIdTasks < ActiveRecord::Migration[6.0]
  def change
    add_reference :tasks, :user, null: false, index: true
  end
end
