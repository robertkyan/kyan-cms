class CreatePages < ActiveRecord::Migration[5.0]
  def change
    create_table :pages do |t|
      t.string :title
      t.text :introduction
      t.boolean :published
      t.date :publish_on
      t.text :body
      t.string :meta_title
      t.text :meta_keywords
      t.text :meta_description

      t.timestamps
    end
  end
end
