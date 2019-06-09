module PaginationHelper
  def pager(data, keep_params = {})
    displayed_pages_lower_bound = 0;
    displayed_pages_upper_bound = 0;

    if data.total_pages <= 10
      displayed_pages_lower_bound = 1;
      displayed_pages_upper_bound = data.total_pages;
    else
      # Make sure if we're on the last page, and there are enough previous pages, we still show 10 pages total up to the last page
      sliding_lower_bound = data.page >= data.total_pages - 4 ? data.total_pages - 9 : data.page - 5;
      displayed_pages_lower_bound = data.page >= 10 ? sliding_lower_bound : 1;

      # Make sure the next upper bound isn't outside of the range of pages available
      next_sliding_upper_bound = data.page + 4 > data.total_pages ? data.total_pages : data.page + 4;
      displayed_pages_upper_bound = data.page >= 10 ? next_sliding_upper_bound : 10;
    end

    data = {
      keep_params: keep_params,
      current_page: data.page,
      total_pages: data.total_pages,
      displayed_items_lower_bound: data.page == 1 ? 1 : ((data.page - 1) * data.per_page) + 1,
      displayed_items_upper_bound: data.page * data.per_page > data.total_items ? data.total_items : data.page * data.per_page,
      total_items: data.total_items,
      displayed_page_numbers: (displayed_pages_lower_bound..displayed_pages_upper_bound).to_a
    }

    render "partials/paginator", data
  end
end
