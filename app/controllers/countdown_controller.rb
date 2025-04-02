class CountdownController < ApplicationController
  def index
    @top_event = Event.includes(:comments, :event_type).find_by(top_display: true)
    @all_events = Event.includes(:event_type).all
  end

  def new
  end
end
