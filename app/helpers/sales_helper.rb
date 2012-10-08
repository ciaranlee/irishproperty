module SalesHelper
  def order_by_link(attribute_name)
    link_to attribute_name, params.merge(:page => nil, :order => (params[:order] == "#{attribute_name}-asc" ? "#{attribute_name}-desc" : "#{attribute_name}-asc") )
  end

  def filter_link(sale, attribute_name)
    value = sale.send(attribute_name)
    link_to value, params.merge(attribute_name => value)
  end

  def address_fragment_link(fragment)
    address_string = fragment
    address_string = $1 if fragment.match(/^\d*(.+)/)
    link_to fragment, params.merge(:address => address_string.strip)
  end

  def sparkline_image(data)
    sorted_data = data.sort
    data_min = sorted_data.first
    data_max = sorted_data.last
    graph_range = "#{data_min},#{data_max}"
    data_string = data.join(',')
    image_size = '100x30'
    colours = '336699'
    label_position = (data_max && data_max > 0) ? "0,#{(data.last*100)/data_max}" : '0,50'
    image_tag "http://chart.apis.google.com/chart?cht=lc&chds=#{graph_range}&chs=#{image_size}&chd=t:#{data_string}&chco=#{colours}&chls=1,1,0&chm=o,990000,0,#{data.length},4&chxt=r,x,y&chxs=0,990000,11,0,_|1,990000,1,0,_|2,990000,1,0,_&chxl=0:|#{data[-1]}|1:||2:||&chxp=#{label_position}", :title => "#{data.length} values from #{data_min} to #{data_max}"
  end

  def stat_explanation(stat)
    {
      :sum => 'Total volume of all transactions',
      :transaction_count => 'Number of transactions',
      :average => 'Average price',
      :median => 'Median price'
    }[stat]
  end
end
