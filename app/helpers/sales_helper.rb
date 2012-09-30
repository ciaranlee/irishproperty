module SalesHelper
  def order_by_link(attribute_name)
    link_to attribute_name, params.merge(:page => nil, :order => (params[:order] == "#{attribute_name}-asc" ? "#{attribute_name}-desc" : "#{attribute_name}-asc") )
  end

  def filter_link(sale, attribute_name)
    value = sale.send(attribute_name)
    link_to value, params.merge(attribute_name => value)
  end
end
