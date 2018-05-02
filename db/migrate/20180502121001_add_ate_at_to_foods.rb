class AddAteAtToFoods < ActiveRecord::Migration[5.0]
  def change
    add_column :foods, :ate_at, :string
  end
end
