class OffersController < ApplicationController

  def search
    result = RetrieveOffers.call(pub0: params[:pub0], uid: params[:uid], page: params[:page])
    if result.success?
      @offers = result.offers
    else

    end
  end

  def new_search
  end
end