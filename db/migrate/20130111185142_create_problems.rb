class CreateProblems < ActiveRecord::Migration
  def change
    create_table :problems do |t|
      t.string :title
      t.text   :prompt
      t.string :answer
    end
  end
end
