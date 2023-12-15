require 'rails_helper'

RSpec.describe HotelSerializer, type: :serializer do
  let(:hotel) { create(:hotel) }

  subject { described_class.new(hotel).as_json }

  it 'includes the correct attributes' do
    expect(subject.keys).to contain_exactly(
      :id, :destination_id, :name, :location, :description, :amenities, :images, :booking_conditions
    )
  end

  describe '#location' do
    it 'returns the correct location structure' do
      expected_location = {
        lat: hotel.lat,
        lng: hotel.lng,
        postal_code: hotel.postal_code,
        city: hotel.city,
        country: hotel.country.name
      }

      expect(subject[:location]).to eq(expected_location)
    end
  end

  describe '#amenities' do
    context 'when there are amenities' do
      it 'returns the correct amenities structure' do
        amenity = create(:amenity)
        hotel.amenities << amenity

        expected_amenities = {
          amenity.amenity_type => [amenity.name]
        }

        expect(subject[:amenities]).to eq(expected_amenities)
      end
    end

    context 'when there are no amenities' do
      it 'returns an empty hash for amenities' do
        expect(subject[:amenities]).to eq({})
      end
    end
  end

  describe '#images' do
    context 'when there are images' do
      it 'returns the correct images structure' do
        image = create(:image, hotel: hotel)
        expected_images = {
          image.image_type => [
            {
              link: image.link,
              description: image.description
            }
          ]
        }

        expect(subject[:images]).to eq(expected_images)
      end
    end

    context 'when there are no images' do
      it 'returns an empty hash for images' do
        expect(subject[:images]).to eq({})
      end
    end
  end

  describe 'edge cases' do
    context 'when the hotel has no associated country' do
      before { hotel.country = nil }

      it 'handles nil country gracefully in location' do
        expect(subject[:location][:country]).to be_nil
      end
    end
  end
end
