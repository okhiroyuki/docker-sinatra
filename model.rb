configure :development, :test, :production do
    ActiveRecord::Base.configurations = YAML.load_file('config/database.yml')
end
