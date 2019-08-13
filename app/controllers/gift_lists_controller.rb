class GiftListsController < ApplicationController
  before_action :set_gift_list, only: [:show, :update, :destroy]
  # GET /gift_lists
  def index
    @gift_lists = GiftList.all.paginate(page: params[:page], per_page: 6)
    json_response(@gift_lists)
  end

  # POST /gift_lists
  def create
    @gift_list = GiftList.create!(gift_list_params)
    json_response(@gift_list, :created)
  end

  # GET /gift_lists/:id
  def show
    json_response(@gift_list)
  end

  # PUT /gift_lists/:id
  def update
    @gift_list.update(gift_list_params)
    head :no_content
  end

  # DELETE /gift_lsits/:id
  def destroy
    @gift_list.destroy
    head :no_content
  end

  private

  def gift_list_params
    # whitelist params
    params.permit(:title, :text, :gift_ids)
  end

  def set_gift_list
    @gift_list = GiftList.find(params[:id])
  end
end