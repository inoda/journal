module Paginator
  extend ActiveSupport::Concern

  included do
    scope :paginate, -> (page_requested = 1, items_per_page = 10) {
      @page_requested = page_requested
      @items_per_page = items_per_page

      def page
        !@page_requested.nil? && @page_requested.to_i > 0 ? @page_requested.to_i : 1
      end

      def per_page
        !@items_per_page.nil? && @items_per_page.to_i > 0 ? @items_per_page.to_i : 10
      end

      def total_items
        limit(nil).offset(nil).count
      end

      def total_pages
        (total_items.to_f / per_page).ceil
      end

      offset = (page - 1) * per_page
      limit(per_page).offset(offset)
    }
  end
end
