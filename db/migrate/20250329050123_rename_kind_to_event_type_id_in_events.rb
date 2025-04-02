class RenameKindToEventTypeIdInEvents < ActiveRecord::Migration[8.0]
  def change
    rename_column :events, :kind, :event_type_id
  end
end
