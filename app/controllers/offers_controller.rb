class OffersController < ApplicationController

  def search
    result = RetrieveOffers.call(pub0: params[:pub0], uid: params[:uid], page: params[:page])
    if result.success?
      @offers = result.offers
    else
      if result.error == 'API_INTERNAL_ERROR'
        @errors = ['There was an error in the Fyber API. Try again later.']
      else
        @errors = [result.message]
      end
    end
  end

  def new_search
  end
end