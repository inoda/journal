class Pagination
  attr_reader :items, :total_items, :page, :per_page, :total_pages
  def initialize(query, page = 1, per_page = 5)
    per_page = !per_page.nil? && per_page.to_i > 0 ? per_page.to_i : 25
    page = !page.nil? && page.to_i > 0 ? page.to_i : 1
    offset = (page - 1) * per_page

    @items = query.limit(per_page).offset(offset)
    @total_items = query.count
    @page = page
    @per_page = per_page
    @total_pages = (@total_items.to_f / @per_page).ceil
  end
end
