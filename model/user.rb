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
end
