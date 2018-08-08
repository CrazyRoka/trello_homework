class ListsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_dashboard, only: [:new, :create, :destroy]
  before_action :set_list, only: [:destroy, :update]

  def index
    @lists = List.all
  end

  def new
    @list = List.new
  end

  def create
    @list = List.new(list_params)
    @list.dashboard = @dashboard
    respond_to do |format|
      if @list.save
        format.html { redirect_to dashboard_url(@dashboard), notice: 'List successfully created' }
        format.json { render :show, status: :created, location: @list }
      else
        format.html { render :new, dashboard_id: @dashboard.id }
        format.json { render json: @list.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @list.destroy
    respond_to do |format|
      format.html { redirect_to dashboard_url(@dashboard), notice: 'List was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def update
    respond_to do |format|
      if @list.update(list_params)
        # format.html { redirect_to @card.list.dashboard, notice: 'Card was successfully updated.' }
        format.json { render :show, status: :ok, location: @list }
      else
        # format.html { render :edit }
        format.json { render json: @list.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def list_params
    params.require(:list).permit(:title, :position)
  end

  def set_dashboard
    @dashboard = Dashboard.find(params[:dashboard_id])
  end

  def set_list
    @list = List.find(params[:id])
  end
end
