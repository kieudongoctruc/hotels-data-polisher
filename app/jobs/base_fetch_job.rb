class BaseFetchJob < ApplicationJob
  queue_as :default

  def perform
    hotels = FetchService.new(url).call
    hotels.each_slice(100) do |hotel_batch|
      UpdateHotelsJob.perform_later(hotel_batch, supplier_name)
    end
  end
end
