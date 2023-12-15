namespace :setup do
  task hotels_updater_and_polisher: :environment do
    FetchFromAcmeSupplierJob.perform_now
    FetchFromPatagoniaSupplierJob.perform_now
    FetchFromPaperfliesSupplierJob.perform_now
  end
end
