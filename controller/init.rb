# Define a subclass of Ramaze::Controller holding your defaults for all
# controllers

# Here go your requires for subclasses of Controller:
#require 'controller/main'
#require 'controller/news'
#require 'controller/circle'
#require 'controller/works'
#require 'controller/badges'
#require 'controller/forum'
#require 'controller/resources'
#require 'controller/user'

Dir[File::join('controller', '*.rb')].sort.each do |con|
  require con
end