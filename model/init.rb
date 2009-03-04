# Here goes your database connection and options:
require 'sequel'

begin
  DB = Sequel.sqlite
rescue NoMethodError
  raise LoadError, 'Install latest Sequel gem'
end

require 'model/user'

unless User.table_exists?
  puts "table doesn't exist"
  User.create_table
  u = User.new
  u.email = 'admin@giftswappo.com'
  u.password = 'password'
  u.save
#  User.create(:username => 'admin', :password => 'password')
  #User << {:username => 'admin', :password => 'password'}
  puts "user created"
end

require 'model/work'

unless Work.table_exists?
  Work.create_table
end

# Here go your requires for models:
# require 'model/user'
