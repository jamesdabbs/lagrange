class ProblemsController < ApplicationController
  def index
    @problems = Problem.includes(:solutions).paginate(page: params[:page])
  end

  def show
    @problem = Problem.find(params[:id])
  end
end