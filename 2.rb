require 'lotus/router'

run Lotus::Router.new {
  get '/confs/:country', to:
    ->(env) {
    [200, {},
     ["Hello, Ruby Conf #{ env['router.params'][:country].upcase }!"]]
  }
}

# GET /confs/pt
# 200 "Hello, Ruby Conf PT!"
