class ForecastsController < ApplicationController
  def index
    @zip_code = params[:zip_code]
  end
end
