class ApplicationController < ActionController::API
  def page_size
    params[:page_size] || 500
  end

  def page_number
    params[:page_number] || 1
  end

  def meta_attributes(resource = nil)
    {}.tap do |meta|
      if resource.present?
        meta[:total_pages] = (resource.total_count.to_f / page_size.to_f).ceil
        meta[:total_items] = resource.total_count
        meta[:page_number] = page_number
        meta[:page_size] = page_size
        meta
      end
    end
  end
end
