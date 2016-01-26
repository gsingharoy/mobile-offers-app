class RetrieveOffers
  include Interactor

  def call
    context.uid || context.fail!(error: 'INPUT_PARAMETER_MISSING', message: ':uid missing')
    context.pub0 || context.fail!(error: 'INPUT_PARAMETER_MISSING', message: ':pub0 missing')
    context.page || context.fail!(error: 'INPUT_PARAMETER_MISSING', message: ':page missing')
    retrieve_response
  end

  private

  def retrieve_response
    case response.code.to_i
    when 200
      handle_success_response
    when 500, 502
      context.fail!(error: 'API_INTERNAL_ERROR', message: 'Internal error in API')
    else
      context.fail!(error: 'API_ERROR', message: "Got error code #{response.code}")
    end
  end

  def handle_success_response
    context.offers = []
    if response_body[:message] == 'OK'
      #stub
    end
  end

  def response
    @response ||= ApiClients::Fyber::MobileOffers.new(uid: context.uid,
      pub0: context.pub0,
      page: context.page).fetch
  end

  def response_body
    @response_body ||= ActiveSupport::HashWithIndifferentAccess.new(JSON(response.body))
  end
end