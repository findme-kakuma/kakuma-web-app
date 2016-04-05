class Admin::CountriesController < Admin::ApplicationController
  def index
    @countries = Country.all
  end
end
