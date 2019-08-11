require 'rails_helper'

RSpec.describe 'Gifts API', type: :request do
  # initialize test data 
  let!(:gifts) { create_list(:gift, 10) }
  let(:gift_id) { gifts.first.id }

  # Test suite for GET /gifts
  describe 'GET /gifts' do
    # make HTTP get request before each example
    before { get '/gifts' }

    it 'returns gifts' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /gifts/:id
  describe 'GET /gifts/:id' do
    before { get "/gifts/#{gift_id}" }

    context 'when the record exists' do
      it 'returns the gift' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(gift_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:gift_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Gift/)
      end
    end
  end

  # Test suite for POST /gifts
  describe 'POST /gifts' do
    # valid payload
    let(:valid_attributes) { { title: 'Title Xxx', text: 'Text Xxx' } }

    context 'when the request is valid' do
      before { post '/gifts', params: valid_attributes }

      it 'creates a gift' do
        expect(json['title']).to eq('Title Xxx')
        expect(json['text']).to eq('Text Xxx')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/gifts', params: { title: 'Foobar' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Text can't be blank/)
      end
    end
  end

  # Test suite for PUT /gifts/:id
  describe 'PUT /gifts/:id' do
    let(:valid_attributes) { { title: 'Shopping' } }

    context 'when the record exists' do
      before { put "/gifts/#{gift_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /gifts/:id
  describe 'DELETE /gifts/:id' do
    before { delete "/gifts/#{gift_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end