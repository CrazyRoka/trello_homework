class DashboardsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_dashboard, only: [:show, :edit, :update, :destroy, :copy]

  def index
    @dashboards = Dashboard.all
  end

  def show
  end

  def new
    @dashboard = Dashboard.new
  end

  def create
    @dashboard = Dashboard.new(dashboard_params)
    @dashboard.owner = current_user
    @dashboard.users << current_user

    respond_to do |format|
      if @dashboard.save
        format.html { redirect_to dashboards_url, notice: 'Dashboard successfully created' }
        format.json { render :show, status: :created, location: @dashboard }
      else
        format.html { render :new }
        format.json { render json: @dashboard.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @dashboard.destroy
    respond_to do |format|
      format.html { redirect_to dashboards_url, notice: 'Dashboard was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def edit
    p @dashboard
  end

  def update
    respond_to do |format|
      if @dashboard.update(dashboard_params)
        format.html { redirect_to @dashboard, notice: 'Dashboard was successfully updated.' }
        format.json { render :show, status: :ok, location: @dashboard }
      else
        format.html { render :edit }
        format.json { render json: @dashboard.errors, status: :unprocessable_entity }
      end
    end
  end

  def copy
    @dashboard = CopyDashboard.new.call(@dashboard)
    respond_to do |format|
      if @dashboard.value_or(false)
        format.html { redirect_to @dashboard.value!, notice: 'Dashboard was successfully duplicated.' }
        format.json { render :show, status: :ok, location: @dashboard }
      else
        format.html { render :edit }
        format.json { render json: @dashboard.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def dashboard_params
    params.require(:dashboard).permit(:title, :public)
  end

  def set_dashboard
    @dashboard = Dashboard.find(params[:id])
  end
end
