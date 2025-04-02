class CreateComments < ActiveRecord::Migration[8.0]
  def change
    create_table :comments do |t|
      t.references :event, null: false, foreign_key: true
      t.text :context
      t.date :comment_date
      t.string :commenter

      t.timestamps
    end
  end
end
