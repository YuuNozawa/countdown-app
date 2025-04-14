class Event < ApplicationRecord
    attr_accessor :year, :month, :day

    validates :event_name, presence: true
    validate :valid_event_day
    belongs_to :event_type
    has_many :comments, dependent: :destroy
    before_save :ensure_only_one_top_display
    after_destroy :ensure_one_top_remains
    before_validation :combine_date_fields

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

    def combine_date_fields
      return if year.blank? && month.blank? && day.blank?
      begin
        self.event_day = Date.new(year.to_i, month.to_i, day.to_i)
      rescue ArgumentError
        self.event_day = nil
      end
    end

    def valid_event_day
        if year.blank? || month.blank? || day.blank?
            errors.add(:base, "Event date can't be blank")
        elsif event_day.nil?
            errors.add(:base, "Event date is not a valid date")
        end
    end
end
