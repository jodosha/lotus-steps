require 'lotus/router'

run Lotus::Router.new {
  get '/', to: ->(env) { [200, {}, ['Hello, RubyConf PT!']] }
}

# GET /
# 200 "Hello, RubyConf PT!"
