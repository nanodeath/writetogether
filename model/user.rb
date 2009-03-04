# To change this template, choose Tools | Templates
# and open the template in the editor.

class User < Sequel::Model
  
  set_schema do
    primary_key :id
    String :email
    String :password

    # Profile stuff
    String :name, :default => nil
    String :interests, :default => nil
    String :city, :default => nil
    String :state_county, :default => nil
    String :country, :default => nil

    # Profile security stuff
    # 2 is all, 1 is guild, 0 is private
    Integer :profile_visibility, :default => 2
    Integer :name_visibility, :default => 2
    Integer :email_visibility, :default => 0
    Integer :interests_visibility, :default => 1
    Integer :city_visibility, :default => 0
    Integer :state_county_visibility, :default => 1
    Integer :country_visibility, :default => 2
  end

  one_to_many :work

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
end