class CreateOrgGits < ActiveRecord::Migration[5.1]
  def change
    create_table :org_gits do |t|
      t.string :name

      t.timestamps
    end
  end
end
