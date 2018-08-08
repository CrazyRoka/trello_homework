class CardsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_list, only: [:new, :create]
  before_action :set_card, only: [:update]

  def new
    @card = Card.new
  end

  def create
    @card = Card.new(card_params)
    @card.list = @list
    respond_to do |format|
      if @card.save
        format.html { redirect_to dashboard_url(@list.dashboard), notice: 'Card successfully created' }
        format.json { render :show, status: :created, location: @card }
      else
        format.html { render :new, dashboard_id: @list.dashboard.id }
        format.json { render json: @card.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @card.update(card_params)
        # format.html { redirect_to @card.list.dashboard, notice: 'Card was successfully updated.' }
        format.json { render :show, status: :ok, location: @card }
      else
        # format.html { render :edit }
        format.json { render json: @card.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def card_params
    params.require(:card).permit(:title, :text, :due_date, :list_id, :position)
  end

  def set_list
    @list = List.find(params[:list_id])
  end

  def set_card
    @card = Card.find(params[:id])
  end
end
