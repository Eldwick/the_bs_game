class CreateClaims < ActiveRecord::Migration
  def change
    create_table :claims do |t|
      t.string :subject
      t.boolean :truth

      t.timestamps
    end
  end
end
