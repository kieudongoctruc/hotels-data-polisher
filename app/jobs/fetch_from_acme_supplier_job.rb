class FetchFromAcmeSupplierJob < ApplicationJob
  URL = 'https://5f2be0b4ffc88500167b85a0.mockapi.io/suppliers/acme'
  SUPPLIER_NAME = 'Acme'

  queue_as :default

  def perform
    hotels = FetchService.new(URL).call
    hotels.each_slice(100) do |hotel_batch|
      UpdateHotelsJob.perform_later(hotel_batch, SUPPLIER_NAME)
    end
  end
end
