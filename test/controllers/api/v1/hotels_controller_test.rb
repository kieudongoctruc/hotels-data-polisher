require 'rails_helper'

RSpec.describe Api::V1::HotelsController, type: :controller do
  describe 'GET #index' do
    context 'with valid parameters' do
      let(:valid_params) { { page_size: 10, page_number: 1 } }

      before do
        create_list(:hotel, 15)
      end

      it 'returns a successful response' do
        get :index, params: valid_params
        expect(response).to have_http_status(:success)
      end

      it 'returns hotels in JSON format' do
        get :index, params: valid_params
        expect(response.content_type).to eq('application/json')
      end

      it 'caches the result' do
        expect(Rails.cache).to receive(:fetch).and_call_original
        get :index, params: valid_params
      end

      it 'paginates the hotels' do
        get :index, params: valid_params
        parsed_response = JSON.parse(response.body)
        expect(parsed_response['hotels'].count).to eq(10)
      end

      it 'returns the correct JSON structure' do
        get :index, params: valid_params
        parsed_response = JSON.parse(response.body)

        expect(parsed_response).to have_key('hotels')
        expect(parsed_response).to have_key('meta')
        expect(parsed_response['meta']).to have_key('total_hotels')
        expect(parsed_response['meta']).to have_key('page')
        expect(parsed_response['meta']).to have_key('page_size')
      end

      it 'returns the correct meta attributes' do
        get :index, params: valid_params
        parsed_response = JSON.parse(response.body)

        expect(parsed_response['meta']['total_hotels']).to eq(15)
        expect(parsed_response['meta']['page']).to eq(1)
        expect(parsed_response['meta']['page_size']).to eq(10)
      end
    end

    context 'when there are no hotels' do
      it 'returns an empty array' do
        Hotel.destroy_all
        get :index, params: { page_size: 10, page_number: 1 }
        parsed_response = JSON.parse(response.body)
        expect(parsed_response['hotels']).to be_empty
      end
    end

    context 'with invalid parameters' do
      it 'handles missing page_size gracefully' do
        get :index, params: { page_number: 1 }
        expect(response).to have_http_status(:bad_request)
      end

      it 'handles missing page_number gracefully' do
        get :index, params: { page_size: 10 }
        expect(response).to have_http_status(:bad_request)
      end

      it 'handles invalid page_size gracefully' do
        get :index, params: { page_size: 'invalid', page_number: 1 }
        expect(response).to have_http_status(:bad_request)
      end

      it 'handles invalid page_number gracefully' do
        get :index, params: { page_size: 10, page_number: 'invalid' }
        expect(response).to have_http_status(:bad_request)
      end
    end

    context 'when there is an error fetching hotels' do
      before do
        allow(Hotel).to receive(:includes).and_raise(StandardError, 'An error occurred')
      end

      it 'handles the error gracefully' do
        get :index, params: { page_size: 10, page_number: 1 }
        expect(response).to have_http_status(:internal_server_error)
        parsed_response = JSON.parse(response.body)
        expect(parsed_response['error']).to eq('An error occurred')
      end
    end
  end
end
