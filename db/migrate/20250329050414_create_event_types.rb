class CreateEventTypes < ActiveRecord::Migration[8.0]
  def change
    create_table :event_types do |t|
      t.string :icon_filename

      t.timestamps
    end
  end
end
