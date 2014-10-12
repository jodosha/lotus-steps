require 'lotus/router'
require 'lotus/controller'
require 'lotus/model'

Conference = Struct.new(:id, :country, :name) do
  def initialize(attributes = {})
    @id, @country, @name = attributes.values_at(:id, :country, :name)
  end
end

class ConferenceRepository
  include Lotus::Repository

  def self.by_country(country)
    query do
      where(country: country)
    end.first
  end
end

Lotus::Model.configure do
  adapter :sql, 'postgres://localhost/conferences'

  mapping do
    collection :conferences do
      entity     Conference
      repository ConferenceRepository

      attribute :id,      Integer
      attribute :country, String, as: :country_code
      attribute :name,    String
    end
  end
end

Lotus::Model.load!

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
