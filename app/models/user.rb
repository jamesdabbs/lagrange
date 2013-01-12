class User
  include Singleton

  def config
    @config ||= YAML.load File.read "#{Rails.root}/config/user.yml"
  end

  class << self
    def editor_url(path)
      "#{instance.config['editor']}://open/?url=file://#{path}"
    end

    def solution_path
      instance.config['solution_path']
    end
  end
end