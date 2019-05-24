class SampleNameChangeColumnType < ActiveRecord::Migration[5.2]
  def change
    change_column(:courses, :location, :string)
    change_column(:courses, :category, :string)
  end
end
