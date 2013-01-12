module ProblemHelper
  def solution_summary(problem, language)
    solution = problem.solution(language)
    render partial: "solution_summary.html.haml", locals: { solution: solution }
  end
end