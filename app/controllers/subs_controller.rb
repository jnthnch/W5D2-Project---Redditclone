class SubsController < ApplicationController
  def new
    @sub = Sub.new
  end

  def edit
    @sub = Sub.find(params[:id])
  end

  def update
  end

  def index
    @subs = Sub.all
  end

  def show
    @sub = Sub.find(params[:id])

  end

  def create
    @sub = Sub.new(sub_params)
    @sub.moderator_id = moderator.id
    if @sub.save
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :new
    end

  end

  def sub_params
    params.require(:sub).permit(:title, :description)
  end
end
