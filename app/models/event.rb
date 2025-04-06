class Event < ApplicationRecord
    belongs_to :event_type
    has_many :comments, dependent: :destroy
    before_save :ensure_only_one_top_display
    after_destroy :ensure_one_top_remains

    private

    def ensure_only_one_top_display
        if top_display
            Event.where.not(id: self.id).update_all(top_display: false)
        end
    end

    def ensure_one_top_remains
        unless Event.exists?(top_display: true)
            fallback = Event.order(:id).first
            fallback&.update_column(:top_display, true)
        end
    end
end
