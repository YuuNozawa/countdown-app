class EventsController < ApplicationController
  before_action :set_event, only: [ :edit, :update, :destroy ]
  def index
    @event = Event.includes(:comments, :event_type).find_by(top_display: true)
    @all_events = Event.includes(:event_type).order("top_display DESC, event_day ASC")
  end

  def show
    @event = Event.includes(:comments, :event_type).find(params[:id])
    @all_events = Event.includes(:event_type).order("top_display DESC, event_day ASC")
    render :index
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      redirect_to countdown_events_path, notice: "Saved!"
    else
      flash.now[:alert] = "save failed"
      render :new, status: :unprocessable_entity and return
    end
  end

  def edit
  end

  def update
    if @event.update(event_params)
      redirect_to countdown_events_path, notice: "Updated!"
    else
      flash.now[:alert] = "save failed"
      render :edit, status: :unprocessable_entity and return
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
