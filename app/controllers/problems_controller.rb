class ProblemsController < ApplicationController
  def index
    @problems = Problem.includes(:solutions).all
  end

  def show
    @problem = Problem.find(params[:id])
  end
end