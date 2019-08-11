class GiftsController < ApplicationController
  before_action :set_gift, only: [:show, :update, :destroy]
  # GET /gifts
  def index
    @gifts = Gift.all
    json_response(@gifts)
  end

  # POST /gifts
  def create
    @gift = Gift.create!(gift_params)
    json_response(@gift, :created)
  end

  # GET /gifts/:id
  def show
    json_response(@gift)
  end

  # PUT /gifts/:id
  def update
    @gift.update(gift_params)
    head :no_content
  end

  # DELETE /gifts/:id
  def destroy
    @gift.destroy
    head :no_content
  end

  private

  def gift_params
    # whitelist params
    params.permit(:title, :text)
  end

  def set_gift
    @gift = Gift.find(params[:id])
  end
end