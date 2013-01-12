class SolutionsController < ApplicationController
  before_filter :lookup_solution

  def show
  end

  def update
    @solution.compute!
    redirect_to action: 'show'
  end

  private

  def lookup_solution
    @solution = Solution.find params[:id]
  end
end