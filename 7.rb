require 'lotus'

module RubyConf
  class Application < Lotus::Application
    configure do
      routes    'config/routes'
      mapping   'config/mapping'
      templates 'app/templates'

      load_paths << 'app'
    end
  end
end

run RubyConf::Application.new

# GET (text) /confs/pt
# 200 "Olá, RubyConf PT!"
#
# GET (html) /confs/pt
# 200 "<h1>Olá, RubyConf PT!</h1>"
