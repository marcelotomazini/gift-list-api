require 'rails_helper'

RSpec.describe 'Gift Lists API' do
  # initialize test data 
  let!(:gift) { create(:gift) }
  let!(:gift_lists) { create_list(:gift_list, 10) }
  let(:gift_id) { gift.id }
  let(:gift_list_id) { gift_lists.first.id }

  # Test suite for GET /gift_lists
  describe 'GET /gift_lists' do
    # make HTTP get request before each example
    before { get '/gift_lists' }

    it 'returns gift_lists' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /gift_lists/:id
  describe 'GET /gift_lists/:id' do
    before { get "/gift_lists/#{gift_list_id}" }

    context 'when the record exists' do
      it 'returns the gift' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(gift_list_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:gift_list_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Gift/)
      end
    end
  end

  # Test suite for POST /gift_lists
  describe 'POST /gift_lists' do
    # valid payload
    let(:valid_attributes) { { title: 'Title Xxx', text: 'Text Xxx', gift_ids: [gift_id] } }

    context 'when the request is valid' do
      before { post '/gift_lists', params: valid_attributes }

      it 'creates a gift list' do
        expect(json['title']).to eq('Title Xxx')
        expect(json['text']).to eq('Text Xxx')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/gift_lists', params: { title: 'Foobar' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Text can't be blank/)
      end
    end
  end

  # Test suite for PUT /gift_lists/:id
  describe 'PUT /gift_lists/:id' do
    let(:valid_attributes) { { title: 'Shopping' } }

    context 'when the record exists' do
      before { put "/gift_lists/#{gift_list_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /gift_lists/:id
  describe 'DELETE /gift_lists/:id' do
    before { delete "/gift_lists/#{gift_list_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end