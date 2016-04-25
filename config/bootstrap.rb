require 'bundler/setup'
Bundler.require

Dir['./app/**/*.rb'].each { |f| require f }
