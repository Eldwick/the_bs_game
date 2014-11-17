class AddCategoryToClaim < ActiveRecord::Migration
  def change
    add_column :claims, :category, :string
  end
end
