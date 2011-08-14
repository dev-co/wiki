$: << 'lib'

require 'rubygems'
require 'wiki/wiki'

use Rack::ShowExceptions

Wiki.set(:gollum_path, "#{Dir.pwd}/pages")
Wiki.set(:wiki_options, {})

run Wiki
