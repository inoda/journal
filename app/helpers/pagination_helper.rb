module PaginationHelper
  def pager(pagination, current_page = 1)
    current_page = current_page.nil? ? 1 : current_page.to_i

    displayed_pages_lower_bound = 0;
    displayed_pages_upper_bound = 0;

    if pagination.total_pages <= 10
      displayed_pages_lower_bound = 1;
      displayed_pages_upper_bound = this.pagination.total_pages;
    else
      # Make sure if we're on the last page, and there are enough previous pages, we still show 10 pages total up to the last page
      sliding_lower_bound = current_page >= pagination.total_pages - 4 ? pagination.total_pages - 9 : current_page - 5;
      displayed_pages_lower_bound = current_page >= 10 ? sliding_lower_bound : 1;

      # Make sure the next upper bound isn't outside of the range of pages available
      next_sliding_upper_bound = current_page + 4 > pagination.total_pages ? pagination.total_pages : current_page + 4;
      displayed_pages_upper_bound = current_page >= 10 ? next_sliding_upper_bound : 10;
    end

    data = {
      current_page: current_page,
      total_pages: pagination.total_pages,
      displayed_items_lower_bound: current_page == 1 ? 1 : ((current_page - 1) * pagination.per_page) + 1,
      displayed_items_upper_bound: [current_page * pagination.per_page, pagination.total_items].max,
      total_items: pagination.total_items,
      displayed_page_numbers: (displayed_pages_lower_bound..displayed_pages_upper_bound).to_a
    }

    render("partials/paginator", data)
  end
end
