require 'lotus/router'
require 'lotus/controller'

Conference = Struct.new(:country, :name) do
  def initialize(attributes = {})
    @country, @name = attributes.values_at(:country, :name)
  end
end

class ConferenceRepository
  def self.by_country(country)
    conferences.find {|c| c.country == country }
  end

  private
  def self.conferences
    [Conference.new(country: 'pt', name: 'RubyConf PT'),
     Conference.new(country: 'it', name: 'RubyDay')]
  end
end

class Show
  include Lotus::Action

  def call(params)
    conference = ConferenceRepository.by_country(params[:country])
    self.body = "Hello, #{ conference.name }!"
  end
end

run Lotus::Router.new {
  get '/confs/:country', to: Show.new
}

# GET /confs/pt
# 200 "Hello, RubyConf PT!"

# GET /confs/it
# 200 "Hello, RubyDay!"
