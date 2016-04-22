# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bling/api/version'

Gem::Specification.new do |spec|
  spec.name          = "bling-api"
  spec.version       = Bling::Api::VERSION
  spec.authors       = ["Gerson Azevedo"]
  spec.email         = ["gersonazgo@gmail.com"]

  spec.summary       = %q{A gem ideal para quem precisa enviar Notas Fiscais e Pedidos da sua loja/app diretamente para o Bling (www.bling.com.br)}
  spec.description   = %q{A gem ideal para quem precisa enviar Notas Fiscais e Pedidos da sua loja/app diretamente para o Bling (www.bling.com.br)}
  spec.homepage      = "https://github.com/gersonazgo/bling-api.git"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com' to prevent pushes to rubygems.org, or delete to allow pushes to any server."
  end


  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "vcr"
  spec.add_development_dependency "webmock"
  spec.add_development_dependency "guard"
  spec.add_development_dependency "guard-rspec"
  spec.add_development_dependency "awesome_print"
  spec.add_development_dependency "factory_girl"
  spec.add_development_dependency "pry-rails"
  spec.add_dependency "httparty"
  spec.add_dependency "faraday"
  spec.add_dependency "json"
  spec.add_dependency "gyoku"
  spec.add_dependency "rails", ">= 3.1"
end
