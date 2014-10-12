require 'lotus/router'

run Lotus::Router.new {
  get '/', to: ->(env) { [200, {}, ['Welcome!']] }
}

# GET /
# 200 "Welcome!"
