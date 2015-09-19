class SubsController < ApplicationController
  before_action :require_correct_moderator, only: [:edit, :update]

  def index
    @subs = Sub.all
    render :index
  end

  def show
    @sub = Sub.includes(:posts => :author).find(params[:id])
    render :show
  end

  def new
    @sub = Sub.new
    render :new
  end

  def create
    @sub = Sub.new(sub_params)
    @sub.moderator_id = current_user.id
    if @sub.save
      flash[:success] = ["Sub successfully created"]
      redirect_to sub_url(@sub)
    else
      flash[:error] = @sub.errors.full_messages
      render :new
    end
  end

  def destroy
    sub = Sub.find(params[:id])
    sub.destroy
    redirect_to subs_url
  end

  def update
    @sub = Sub.find(params[:id])
    if @sub.update(sub_params)
      flash[:success] = ["Sub successfully updated"]
      redirect_to sub_url(@sub)
    else
      flash[:error] = @sub.errors.full_messages
      render :edit
    end
  end

  def edit
    @sub = Sub.find(params[:id])
    render :edit
  end

  private
  def require_correct_moderator
    sub = Sub.find(params[:id])
    redirect_to subs_url if current_user.id != sub.moderator_id
  end

  def sub_params
    params.require(:sub).permit(:title, :description)
  end
end
