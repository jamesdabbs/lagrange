module User
  Conf = YAML.load File.read "#{Rails.root}/config/user.yml"

  def self.editor_url(path)
    "#{Conf["editor"]}://open/?url=file://#{path}"
  end
end