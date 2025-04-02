class CreateEvents < ActiveRecord::Migration[8.0]
  def change
    create_table :events do |t|
      t.string :event_name
      t.date :event_day
      t.string :kind
      t.boolean :top_display

      t.timestamps
    end
  end
end
