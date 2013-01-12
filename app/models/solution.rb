class Solution < ActiveRecord::Base
  belongs_to :problem

  def compute!
    code         = attach_code
    start        = Time.now
    self.answer  = code.solution
    self.runtime = Time.now - start
    save!
  end

  def language
    self.class.name.split('::').last
  end

  def extension
    self.class.extension
  end

  def dir_path
    "#{Rails.root}/solutions/#{language}"
  end

  def path
    "#{dir_path}/#{problem_id}.#{extension}"
  end

  class << self
    def register_extension(ext, klass)
      @extensions ||= {}
      @extensions[ext] = klass
    end

    def extension(ext=nil)
      if ext.nil?
        @extension
      else
        klass = self
        Solution.register_extension ext, klass
        @extension = ext
      end
    end

    def import(ext)
      klass = @extensions[ext]
      raise "Unrecognized extension: #{ext}" if klass.nil?
      Dir["#{Rails.root}/solutions/**/*.#{ext}"].each do |path|
        if path =~ /(\d+)\.#{ext}$/
          klass.where(problem_id: $1).first_or_create!
        end
      end
    end
  end

  private #---------------------------------------------------------------------

  def attach_code
    raise NotImplementedError
  end
end

Dir["#{Rails.root}/app/models/solution/*"].each { |f| require f }