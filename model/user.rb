# To change this template, choose Tools | Templates
# and open the template in the editor.

class User < Sequel::Model
  
  set_schema do
    primary_key :id
    varchar :email
    varchar :password
  end

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