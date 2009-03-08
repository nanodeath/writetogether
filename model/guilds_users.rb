# To change this template, choose Tools | Templates
# and open the template in the editor.

class GuildsUsers < Sequel::Model
  class Connection
    MEMBER = 0
    SPECIAL = 1
    CREATOR = 2
  end
  unrestrict_primary_key
  set_schema do
    Integer :guild_id
    Integer :user_id
    Integer :connection, :default => GuildsUsers::Connection::MEMBER # 0 is member, 1 is special, 2 is creator

    primary_key [:guild_id, :user_id]
  end

  many_to_one :user
  many_to_one :guild

  def self.connection_to_abbr(conn)
    case conn
    when Connection::MEMBER
      'M'
    when Connection::SPECIAL
      'S'
    when Connection::CREATOR
      'C'
    end
  end
end
