class UpdateHotelsJob < ApplicationJob
  queue_as :default

  def perform(hotel_batch, supplier_name)
    ActivityLog.create(
      name: 'Starting updating hotels',
      from: supplier_name,
      log: {
        batch: hotel_batch.map { |h| h['id'] || h['hotel_id'] || h['Id'] }
      }
    )
    hotel_batch.each do |uncleaned_object|
      parsed_attributes = "Parser::#{supplier_name}".constantize.new(uncleaned_object).attributes
      SaveService.new(parsed_attributes, supplier_name).call
    end
    ActivityLog.create(
      name: 'Finished updating hotels',
      from: supplier_name
    )
  end
end
