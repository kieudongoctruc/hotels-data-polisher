class UpdateHotelsJob < ApplicationJob
  queue_as :default

  def perform(hotel_batch, supplier_name)
    hotel_batch.each do |uncleaned_object|
      parsed_attributes = "Parser::#{supplier_name}".constantize.new(uncleaned_object).attributes
      parsed_attributes.delete_if { |attr| attr.blank? }
      SaveService.new(parsed_attributes).call
    end
  end
end
