$: << 'lib'

require 'rubygems'
require 'gollum'
require 'gollum/frontend/app'

use Rack::ShowExceptions

Precious::App.set(:gollum_path, "#{Dir.pwd}/pages")
Precious::App.set(:wiki_options, {})

run Precious::App
