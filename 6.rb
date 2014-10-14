require 'i18n'
require 'json'
require 'lotus'
require_relative './app/entities/conference'
require_relative './app/repositories/conference_repository'

module RubyConf
  class Application < Lotus::Application
    configure do
      # Routes are available at:
      #
      #   RubyConf::Application.new.routes.path(:home)
      #   RubyConf::Routes.path(:home)
      routes do
        get '/confs/:country', to: 'conferences#show'
      end

      templates 'app/templates'

      mapping do
        collection :conferences do
          entity     Conference
          repository ConferenceRepository

          attribute :id,      Integer
          attribute :country, String, as: :country_code
          attribute :name,    String
          attribute :locale,  String
        end
      end
    end

    load!

    module Controllers::Conferences # this is a controller
      # Full name of this action:
      #   RubyConf::Controllers::Conferences::Show
      class Show
        include RubyConf::Action
        expose :conference

        def call(params)
          @conference = ConferenceRepository.by_country(params[:country])
        end
      end
    end

    module Views::Conferences
      # Full name of this view:
      #   RubyConf::Views::Conferences::Show
      #
      # This will render
      #   app/templates/conferences/show.html.erb
      #
      #   <h1><%= greeting %>, <%= conference.name %>!</h1>
      class Show
        include RubyConf::View

        def greeting
          I18n.t('greeting', locale: conference.locale)
        end
      end

      class JsonShow < Show
        format :json

        def render
          JSON.generate(conference)
        end

        def conference
          super.to_h.merge(
            greeting: greeting
          )
        end
      end
    end
  end
end

run RubyConf::Application.new

# GET (text) /confs/pt
# 200 "Olá, RubyConf PT!"
#
# GET (html) /confs/pt
# 200 <h1>Olá, RubyConf PT!</h1>
#
# GET (json) /confs/pt
# 200 {"id":"1","name":"RubyConf PT", "country":"pt", "greeting":"..."}
