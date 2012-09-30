module SalesHelper
  def order_by_link(attribute_name)
    link_to attribute_name, params.merge(:page => nil, :order => (params[:order] == "#{attribute_name}-asc" ? "#{attribute_name}-desc" : "#{attribute_name}-asc") )
  end
end
