module ProblemHelper
  def solution_summary(problem, language)
    solution = problem.solution(language)
    render partial: "solution_summary", locals: { solution: solution }
  end

  def speed_info(solution)
    rt = solution.runtime
    return unless rt
    if rt.to_f > 60
      "<span class='badge badge-warning'>#{rt}</span>".html_safe
    else
      rt
    end
  end
end