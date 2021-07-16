class CreateUrlProperties < ActiveRecord::Migration[6.1]
  def change
    create_table :url_properties do |t|
      t.string :title
      t.string :long_url
      t.string :unique_url_key

      t.timestamps
    end
  end
end
