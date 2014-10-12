require 'lotus/router'

run Lotus::Router.new {
  get '/confs/:country', to:
    ->(env) {
    [200, {},
     ["Hello, RubyConf #{ env['router.params'][:country].upcase }!"]]
  }
}

# GET /confs/pt
# 200 "Hello, RubyConf PT!"

# GET /confs/in
# 200 "Hello, RubyConf IN!"
