require 'lotus'
require_relative './app/entities/conference'
require_relative './app/repositories/conference_repository'

module RubyConf
  class Application < Lotus::Application
    configure do
      routes do
        get '/confs/:country', to: 'conferences#show'
      end

      templates 'app/templates'

      model.adapter :local, "postgres://localhost/conferences_#{ environment }"

      mapping do
        collection :conferences do
          entity     Conference
          repository ConferenceRepository

          attribute :id,      Integer
          attribute :country, String
          attribute :name,    String
        end
      end
    end

    load!

    module Controllers::Conferences # this is a controller
      class Show
        include RubyConf::Action
        expose :conference

        def call(params)
          @conference = ConferenceRepository.by_country(params[:country])
        end
      end
    end

    module Views::Conferences
      # This will render
      #   app/templates/conferences/show.html.erb
      #
      #   <h1>Hello, <%= conference.name %>!</h1>
      class Show
        include RubyConf::Action
      end

      class TextShow < Show
        format :text

        def render
          "Hello, #{ conference.name }!"
        end
      end
    end
  end
end

run RubyConf::Application.new

# GET (text) /confs/pt
# 200 "Hello, Ruby Conf PT!"
#
# GET (html) /confs/pt
# 200 "<h1>Hello, Ruby Conf PT!</h1>"
