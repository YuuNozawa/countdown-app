class Event < ApplicationRecord
    belongs_to :event_type
    has_many :comments, dependent: :destroy
    before_save :ensure_only_one_top_display

    private

    def ensure_only_one_top_display
        if top_display
            Event.where.not(id: self.id).update_all(top_display: false)
        end
    end
end
