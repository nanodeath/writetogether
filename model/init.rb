# Here goes your database connection and options:
require 'sequel'

begin
  DB = Sequel.sqlite :loggers => [Ramaze::Log]
rescue NoMethodError
  raise LoadError, 'Install latest Sequel gem'
end

require 'model/guild'
require 'model/guilds_users'

require 'model/user'

unless User.table_exists?
  User.create_table
  u = User.new
  u.email = 'admin@giftswappo.com'
  u.password = 'password'
  u.name = "Admin"
  u.save
  ['bob@giftswappo.com', 'jim@giftswappo.com', 'mary@giftswappo.com'].each do |email|
    u = User.new
    u.email = email
    u.password = 'password'
    u.name = email.split("@")[0]
    u.save
  end
#  User.create(:username => 'admin', :password => 'password')
  #User << {:username => 'admin', :password => 'password'}
end


unless Guild.table_exists?
  Guild.create_table
  Guild.create(:name => "Cats", :guild_type => "Whatever", :visibility => Guild::Visibility::LIMITED)
end

unless GuildsUsers.table_exists?
  GuildsUsers.create_table
  guild = Guild.first
  people = User.all
  admin = people.shift
  GuildsUsers.create :guild_id => guild.id, :user_id => admin.id, :connection => GuildsUsers::Connection::CREATOR
  people.each do |m|
    GuildsUsers.create :guild_id => guild.id, :user_id => m.id, :connection => GuildsUsers::Connection::MEMBER
  end
end

require 'model/work'

unless Work.table_exists?
  Work.create_table
end