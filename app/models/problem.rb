require 'open-uri'

class Problem < ActiveRecord::Base
  has_many :solutions

  def url
    "http://projecteuler.net/problems=#{id}"
  end

  def fetch
    doc = Nokogiri::HTML(open(url))
    raise "No problem found" unless doc.title =~ /^Problem #{id}/
    self.title  = doc.at_css('h2').text.strip
    self.prompt = doc.at_css('.problem_content').text.strip
    save!
  end

  class << self
    def populate
      1.upto(409) do |n|
        begin
          find(n).fetch
        rescue ActiveRecord::RecordNotFound
          create!.fetch
        end
      end
    end
  end

end
