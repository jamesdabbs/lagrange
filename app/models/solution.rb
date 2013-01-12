class Solution < ActiveRecord::Base
  belongs_to :problem

  def compute!
    code         = attach_code
    start        = Time.now
    self.answer  = code.solution
    self.runtime = Time.now - start
    self.state   = :answered
    save!
    check
  rescue
    self.state   = :error
    self.error   = $!.to_s
    save!
  end

  def check
    # TODO: pull answers and compare, change state to correct / incorrect
  end

  def language
    Language.by_name self.class.name.split('::').last
  end

  def dir_path
    "#{Rails.root}/solutions/#{language.name.downcase}"
  end

  def path
    "#{dir_path}/#{problem_id}.#{language.extension}"
  end

  class << self
    def attempted
      select { |s| File.exists?(s.path) }
    end
  end

  def attach_code
    raise NotImplementedError
  end
end

Dir["#{Rails.root}/app/models/solution/*"].each { |f| require f }