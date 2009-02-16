require 'rubygems'

require '../rack/lib/rack.rb'
#require 'rack'
require '../ramaze/lib/ramaze.rb'
#require 'ramaze'

# Add directory start.rb is in to the load path, so you can run the app from
# any other working path
$LOAD_PATH.unshift(__DIR__)

# Initialize controllers and models
require 'controller/init'
require 'model/init'

Ramaze.start :adapter => :webrick, :port => 7000
