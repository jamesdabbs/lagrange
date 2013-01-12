require 'open-uri'

class Problem < ActiveRecord::Base
  has_many :solutions

  after_create :create_solutions

  self.per_page = 50

  def url
    "http://projecteuler.net/problem=#{id}"
  end

  def fetch
    doc = Nokogiri::HTML(open(url))
    raise "No problem found" unless doc.title =~ /^Problem #{id}/
    self.title  = doc.at_css('h2').text.strip
    self.prompt = doc.at_css('.problem_content').inner_html
    save!
  end

  def solution(language)
    solutions.find { |s| s.class.name == "Solution::#{language}" }
  end

  def create_solutions
    Language.each do |l|
      solution = l.solution_class.where(problem_id: id).first_or_create!
    end
  end
end
