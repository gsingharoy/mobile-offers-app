require 'rails_helper'

describe ApiClients::Fyber::MobileOffers do
  describe '#initialize' do
    context 'missing :uid in attrs' do
      it 'should raise an expection' do
        expect do
          ApiClients::Fyber::MobileOffers.new(pub0: 'campaign1', page: 2)
        end.to raise_error(RuntimeError, 'missing attrs :uid')
      end
    end
    context 'missing :page in attrs' do
      it 'should raise an expection' do
        expect do
          ApiClients::Fyber::MobileOffers.new(uid: 'user1', pub0: 'campaign1')
        end.to raise_error(RuntimeError, 'missing attrs :page')
      end
    end
    context 'missing :pub0 in attrs' do
      it 'should raise an expection' do
        expect do
          ApiClients::Fyber::MobileOffers.new(uid: 'user1', page: 2)
        end.to raise_error(RuntimeError, 'missing attrs :pub0')
      end
    end
  end
end