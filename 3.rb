require 'lotus/router'
require 'lotus/controller'

class Show
  include Lotus::Action

  def call(params)
    self.body = "Hello, Ruby Conf #{ params[:country].upcase }!"
  end
end

run Lotus::Router.new {
  get '/confs/:country', to: Show.new
}

# GET /confs/pt
# 200 "Hello, Ruby Conf PT!"
