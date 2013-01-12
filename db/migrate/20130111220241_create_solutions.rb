class CreateSolutions < ActiveRecord::Migration
  def change
    create_table :solutions do |t|
      t.string :type
      t.integer :problem_id
      t.string :answer
      t.string :runtime
    end
  end
end
