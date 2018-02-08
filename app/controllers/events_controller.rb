class EventsController < ApplicationController
  def new
  	 @event = Event.new
  end

  def index
    @events = Event.all
  end

  def create
    if logged_in?
      @user = current_user
      @event = @user.created_events.new(event_params)
      if @event.save
        flash[:success] = "L'événement a bien été créé !"
        redirect_to current_user
      else
        render 'new'
        flash.now[:error] = "L'événement n'a pas été créé"
      end
    end
	end

  def show
  	@event = Event.find(params[:id])
  end

 def attend
    if logged_in?
      @event = Event.find(params[:id])
      @event.user_attendees << current_user
      @event.save
      flash[:success] = "Vous êtes inscrit à l'événement !"
      redirect_to events_path
    else
      redirect_to login_path
    end
  end

	private
  def event_params
    	params.require(:event).permit(:description, :date, :place)
  	end 



end
