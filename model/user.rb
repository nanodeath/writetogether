# To change this template, choose Tools | Templates
# and open the template in the editor.

class User < Sequel::Model
  set_schema do
    primary_key :id
    varchar :username
    varchar :password
  end


  def initialize
    
  end

  def self.authenticate(user, pass)
    u = User[user]
    puts "user: #{user.inspect}, #{u.inspect}"
    puts User.length
    puts "password: #{u.password.inspect}"
    !u.nil? && u.password == pass
  end
end
