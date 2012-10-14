class CountiesController < ApplicationController
  caches_action :index, :cache_path => Proc.new { |c| c.params }

  def index
    @counties = County.order('name ASC')
  end
end
