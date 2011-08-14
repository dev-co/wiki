require 'gollum'
require 'gollum/frontend/app'
require 'warden-github'

class Wiki < Precious::App
  enable  :sessions

  use Warden::Manager do |manager|
    manager.default_strategies :github
    manager.failure_app = BadAuthentication

    manager[:github_client_id]    = ENV['GITHUB_CLIENT_ID']     || 'your_client_id'
    manager[:github_secret]       = ENV['GITHUB_CLIENT_SECRET'] || 'your_client_secret'

    manager[:github_scopes]       = 'email,offline_access'
    manager[:github_callback_url] = '/auth/github/callback'
  end

  helpers do
    def ensure_authenticated
      unless env['warden'].authenticate!
        throw(:warden)
      end
    end
  end

  before '/edit/*' do
    ensure_authenticated
  end 

  before '/create' do
    ensure_authenticated
  end

  get '/auth/github/callback' do
    ensure_authenticated
    session['committer_name']  = env['warden'].user.name
    session['committer_email'] = env['warden'].user.email
    redirect '/'
  end

  get '/logout' do
    env['warden'].logout
  end
end

class BadAuthentication < Sinatra::Base
  get '/unauthenticated' do
      status 403
      "Unable to authenticate, sorry bud."
    end
  end

  def self.app
    @app ||= Rack::Builder.new do
    run App
  end
end

