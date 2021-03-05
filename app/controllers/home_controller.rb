class HomeController < ApplicationController
  def index
    if current_user
      redirect_to projects_path
    end
  end
end
