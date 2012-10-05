class SalesController < ApplicationController
  caches_action :index, :cache_path => Proc.new { |c| c.params }
  caches_action :stats, :cache_path => Proc.new { |c| c.params }

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
    filter_sales
    @sales = @sales.order(order_hash[params[:order]] || 'date DESC')
    @average = @sales.average(:price).to_i
    @minimum = @sales.minimum(:price)
    @maximum = @sales.maximum(:price)
    @sum = @sales.sum(:price)
    @sales = @sales.page params[:page]
  end

  def stats
    filter_sales
    @start = Time.parse '2010/01'
    @end = Time.now.at_beginning_of_month
    @months = []
    @sales_stats = []
    t = @start
    while t < @end
      month = t..(t+1.month - 1)
      @months << month
      t += 1.month

      monthly_sales = @sales.where(:date => month)
      prices = monthly_sales.select(:price).all.collect(&:price)
      @sales_stats << {
        :sales => monthly_sales,
        :transaction_count => monthly_sales.count,
        :average => monthly_sales.average(:price).to_i,
        :minimum => monthly_sales.minimum(:price),
        :maximum => monthly_sales.maximum(:price),
        :sum => monthly_sales.sum(:price),
        :median => prices.median.to_i,
        :range => prices.range.to_i,
        :standard_deviation => prices.standard_deviation.to_i,
        :variance => prices.variance.to_i
      }
    end
  end

  def show
    @sale = Sale.find(params[:id])
  end

  def filter_sales
    @sales = Sale
    @filters = {}
    [:address, :postal_code, :county, :description, :size_description].each do |attribute|
      if params[attribute].present?
        if attribute == :address
          @sales = @sales.where("address #{'i' if Rails.env.production?}like ?", "%#{params[:address]}%")
        else
          @sales = @sales.where(attribute => params[attribute])
        end
        @filters[attribute] = params[attribute]
      end
    end
  end
end
