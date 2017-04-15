class AddEmailToPosts < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :email, :string
  end
end
