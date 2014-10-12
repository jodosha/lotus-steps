require 'lotus'

module RubyConf
  class Application < Lotus::Application
    configure do
      model.adapter :local, ENV['DATABASE_URL']

      routes    'config/routes'
      mapping   'config/mapping'
      templates 'app/templates'

      load_paths << 'app'
    end
  end
end

run RubyConf::Application.new

# GET (text) /confs/pt
# 200 "Hello, Ruby Conf PT!"
#
# GET (html) /confs/pt
# 200 "<h1>Hello, Ruby Conf PT!</h1>"
