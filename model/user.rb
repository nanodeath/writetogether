# To change this template, choose Tools | Templates
# and open the template in the editor.

class User < Sequel::Model
  
  class Visibility
    ALL = 2
    GUILD = 1
    PRIVATE = 0
  end
  
  set_schema do
    primary_key :id
    String :email
    String :password

    # Profile stuff
    String :name, :default => "Foofy face"
    String :interests, :default => nil
    String :city, :default => nil
    String :state_province, :default => nil
    String :country, :default => nil

    # Profile security stuff
    # 2 is all, 1 is guild, 0 is private
    Integer :profile_visibility, :default => User::Visibility::ALL
    Integer :name_visibility, :default => User::Visibility::ALL
    Integer :email_visibility, :default => User::Visibility::PRIVATE
    Integer :interests_visibility, :default => User::Visibility::GUILD
    Integer :city_visibility, :default => User::Visibility::PRIVATE
    Integer :state_province_visibility, :default => User::Visibility::GUILD
    Integer :country_visibility, :default => User::Visibility::ALL
  end

  one_to_many :work
  many_to_many :guilds
  many_to_many :created_guilds, :class => "Guild", :conditions => {:connection => GuildsUsers::Connection::CREATOR}

  validates do
    presence_of :email
    presence_of :password
  end

  def self.authenticate(user, pass)
    u = User.find :email => user
    puts "user: #{user.inspect}, #{u.inspect}"
    if !u.nil? && u.password == pass
      Ramaze::Log.info("User #{user} authenticated")
      return u
    else
      Ramaze::Log.info("User #{user} failed to authenticate")
      return nil
    end
  end

  def in_guild_with?(user)
    ret = !(guilds & user.guilds).empty?
    ret
  end

  def can_view_attribute?(target_user, attribute)
    return false unless target_user
    return true if self == target_user
    attribute_visibility = target_user[(attribute.to_s + '_visibility').to_sym]
    return attribute_visibility == User::Visibility::ALL ||
      (self.in_guild_with?(target_user) && attribute_visibility == User::Visibility::GUILD)
  end
end