require 'rubygems'

class String
  def to_a; lines.to_a end
end

#require '../rack/lib/rack.rb'
require 'rack'
#require '../ramaze/lib/ramaze.rb'
require 'ramaze'

# Add directory start.rb is in to the load path, so you can run the app from
# any other working path
$LOAD_PATH.unshift(__DIR__)

Ramaze::Log.info("Converting " + Dir[File.join(__DIR__, '**', '*.sass')].length.to_s + " sass files")
Dir[File.join(__DIR__, '**', '*.sass')].each do |sass_file|
  require 'sass'
  engine = ::Sass::Engine.new(File.read(sass_file))
  css_file = sass_file + '.css'
  File.open(css_file, 'w') {|f| f.write(engine.render)}
  Ramaze::Log.info(sass_file + " => " + css_file)
end

# Initialize controllers and models
require 'controller/init'
require 'model/init'

Ramaze.start :adapter => :webrick, :port => 7000

