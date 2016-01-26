require 'rails_helper'

describe RetrieveOffers do
  describe '#call' do
    context 'missing parameter' do
      context ':uid is missing' do
        let(:subject) do
          RetrieveOffers.call(page: 2, pub0: 'campaign1')
        end
        it 'success? is false' do
          expect(subject.success?).to eq false
        end
        it 'returns correct error' do
          expect(subject.error).to eq 'INPUT_PARAMETER_MISSING'
        end
        it 'returns correct error message' do
          expect(subject.message).to eq ':uid missing'
        end
      end
      context ':page is missing' do
        let(:subject) do
          RetrieveOffers.call(uid: 'user1', pub0: 'campaign1')
        end
        it 'success? is false' do
          expect(subject.success?).to eq false
        end
        it 'returns correct error' do
          expect(subject.error).to eq 'INPUT_PARAMETER_MISSING'
        end
        it 'returns correct error message' do
          expect(subject.message).to eq ':page missing'
        end
      end
      context ':pub0 is missing' do
        let(:subject) do
          RetrieveOffers.call(uid: 'user1', page: 2)
        end
        it 'success? is false' do
          expect(subject.success?).to eq false
        end
        it 'returns correct error' do
          expect(subject.error).to eq 'INPUT_PARAMETER_MISSING'
        end
        it 'returns correct error message' do
          expect(subject.message).to eq ':pub0 missing'
        end
      end
    end
    context 'all parameters passed' do
      [500, 502].each do |response_code|
        context "get response code #{response_code}" do
          before do
            allow_any_instance_of(ApiClients::Fyber::MobileOffers).to receive(:fetch)
              .and_return(OpenStruct.new(code: response_code))
          end
          let(:subject) do
            RetrieveOffers.call(uid: 'user1', page: 2, pub0: 'campaign1')
          end
          it 'success? is false' do
            expect(subject.success?).to eq false
          end
          it 'returns correct error' do
            expect(subject.error).to eq 'API_INTERNAL_ERROR'
          end
          it 'returns correct error message' do
            expect(subject.message).to eq 'Internal error in API'
          end
        end
      end
      [400, 401, 403].each do |response_code|
        context "get response code #{response_code}" do
          before do
            allow_any_instance_of(ApiClients::Fyber::MobileOffers).to receive(:fetch)
              .and_return(OpenStruct.new(code: response_code))
          end
          let(:subject) do
            RetrieveOffers.call(uid: 'user1', page: 2, pub0: 'campaign1')
          end
          it 'success? is false' do
            expect(subject.success?).to eq false
          end
          it 'returns correct error' do
            expect(subject.error).to eq 'API_ERROR'
          end
          it 'returns correct error message' do
            expect(subject.message).to eq "Got error code #{response_code}"
          end
        end
      end
      context 'response_code is 200' do
        let(:response) { OpenStruct.new(code: 200, body: response_body) }
        context 'no content' do
          let(:response_body) { { code: 'NO_CONTENT' }.to_json }
          before do
            allow_any_instance_of(ApiClients::Fyber::MobileOffers).to receive(:fetch)
              .and_return(response)
          end
          let(:subject) do
            RetrieveOffers.call(uid: 'user1', page: 2, pub0: 'campaign1')
          end
          it 'success? is true' do
            expect(subject.success?).to eq true
          end
          it 'offers is empty' do
            expect(subject.offers).to eq ([])
          end
        end
        context 'content is there' do
          let(:response_body) do
            File.read(File.join([Rails.root, 'spec', 'fixtures', 'api_responses','fyber', 'mobile_offers.json']))
          end
          before do
            allow_any_instance_of(ApiClients::Fyber::MobileOffers).to receive(:fetch)
              .and_return(response)
          end
          let(:subject) do
            RetrieveOffers.call(uid: 'user1', page: 2, pub0: 'campaign1')
          end
          it 'success? is true' do
            expect(subject.success?).to eq true
          end
          it 'offers is not empty' do
            expect(subject.offers.count).to eq JSON(response_body)['offers'].count
          end
          it 'adds title to the created offers' do
            expected_titles = JSON(response_body)['offers'].map{ |o| o['title'] }
            expect(subject.offers.map(&:title)).to eq expected_titles
          end
          it 'adds payout to the created offers' do
            expected_payouts = JSON(response_body)['offers'].map{ |o| o['payout'] }
            expect(subject.offers.map(&:payout)).to eq expected_payouts
          end
          it 'adds thumbnail to the created offers' do
            expected_thumbnails = JSON(response_body)['offers'].map{ |o| o['thumbnail']['lowres'] }
            expect(subject.offers.map(&:thumbnail)).to eq expected_thumbnails
          end
        end
      end
    end
  end
end