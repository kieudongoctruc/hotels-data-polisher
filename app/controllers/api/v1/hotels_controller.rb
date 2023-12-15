# frozen_string_literal: true

module Api
  module V1
    class HotelsController < ApplicationController

      def index
        hotels = Rails.cache.fetch(cache_key, expires_in: 10.minutes) do
          Kaminari.paginate_array(all).page(page_number).per(page_size)
        end

        render json: hotels,
               root: "hotels",
               meta: meta_attributes(hotels),
               adapter: :json
      end

      private
      def cache_key
        [id, destination_id, page_size, page_number].join('-')
      end

      def hotels_params
        params.permit(:id, :destination_id, :page_size, :page_number, :id => [], :destination_id => [])
      end

      def all
        Hotel.includes(:general_amenities, :room_amenities, :rooms_images, :site_images, :amenities_images, :country).where(filter_params)
      end

      def filter_params
        { id: id, destination_id: destination_id }.delete_if{ |_k, v| v.blank? }
      end

      def id
        hotels_params[:id]
      end

      def destination_id
        hotels_params[:destination_id]
      end
    end
  end
end
