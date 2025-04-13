class EventsController < ApplicationController
  before_action :set_event, only: [ :edit, :update, :destroy ]
  def index
    @top_event = Event.includes(:comments, :event_type).find_by(top_display: true)
    @all_events = Event.includes(:event_type).all
  end

  def new
    @event = Event.new
  end

  def create
    ep = event_params
    begin
      event_day = Date.new(ep.delete(:year).to_i, ep.delete(:month).to_i, ep.delete(:day).to_i)
    rescue ArgumentError
      flash.now[:alert] = "invalid date"
      render :new and return
    end
    @event = Event.new(ep.merge(event_day: event_day))
    if @event.save
      redirect_to countdown_events_path, notice: "Saved!"
    else
      flash.now[:alert] = "save failed"
      render :new
    end
  end

  def edit
  end

  def update
    ep = event_params
    begin
      event_day = Date.new(ep.delete(:year).to_i, ep.delete(:month).to_i, ep.delete(:day).to_i)
    rescue ArgumentError
      flash.now[:alert] = "invalid date"
      render :new and return
    end

    if @event.update(ep.merge(event_day: event_day))
      redirect_to countdown_events_path, notice: "Updated!"
    else
      Rails.logger.debug("保存失敗： #{@Event.errors.full_messages.join(', ')}")
      flash.now[:alert] = "save failed"
      render :edit
    end
  end

  def destroy
    @event.destroy
    redirect_to countdown_events_path, notice: "Deleted!"
  end

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:event_name, :year, :month, :day, :top_display, :event_type_id)
  end
end
