class AddExpireOnToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :expire_on, :date, null: false, default: -> { 'NOW()' }
  end
end
