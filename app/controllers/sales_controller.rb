class SalesController < ApplicationController
  caches_action :index

  def index
    order_hash = {
      'price-asc' => 'price ASC',
      'price-desc' => 'price DESC',
      'county-asc' => 'county ASC',
      'county-desc' => 'county DESC',
      'full_market_price-asc' => 'full_market_price ASC',
      'full_market_price-desc' => 'full_market_price DESC',
      'date-asc' => 'date ASC',
      'date-desc' => 'date DESC'
    }
    @sales = Sale.order(order_hash[params[:order]] || 'date DESC')
    @filters = {}
    [:postal_code, :county, :description, :size_description].each do |attribute|
      if params[attribute].present?
        @sales = @sales.where(attribute => params[attribute])
        @filters[attribute] = params[attribute]
      end
    end
    @sales = @sales.page params[:page]
  end

  def show
    @sale = Sale.find(params[:id])
  end
end
