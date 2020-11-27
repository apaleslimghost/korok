class HomeController < ApplicationController
  def index
    redirect_to controller: :projects, action: :index
  end
end
