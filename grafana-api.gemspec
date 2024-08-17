Gem::Specification.new do |s|
  s.name        = 'grafana-api'
  s.version     = '0.2.2'
  s.date        = '2023-03-13'
  s.summary     = "Grafana HTTP API Wrapper"
  s.description = "A wrapper for the Grafana HTTP API"
  s.authors     = ["Alain Lefebvre", "Valentin Gololobov"]
  s.email       = 'alain.lefebvre@gmail.com'
  s.files       = ["lib/grafana.rb"] + Dir["lib/grafana/*"]
  s.homepage    = 'http://github.com/hartfordfive/ruby-grafana-api'
  s.license     = 'MIT'
  s.add_runtime_dependency 'json',         '~> 2.6'
  s.add_runtime_dependency 'rest-client',  '~> 2.1'
end
