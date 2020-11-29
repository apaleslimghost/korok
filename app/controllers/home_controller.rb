class HomeController < ApplicationController
  def index
    @parts = Part.all
      .filter { |p| p.remaining_quantity < 0 }.sort_by(&:remaining_quantity)

    @projects = Project.all
  end
end
