class CreateRepGits < ActiveRecord::Migration[5.1]
  def change
    create_table :rep_gits do |t|
      t.integer :Orgname_id
      t.string :repname
      t.string :language

      t.timestamps
    end
  end
end
