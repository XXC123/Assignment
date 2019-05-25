class CreateVotes < ActiveRecord::Migration[5.2]
  def change
    create_table :votes do |t|
      t.integer :user
      t.integer :course

      t.timestamps
    end
  end
end
