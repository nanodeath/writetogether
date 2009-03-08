# To change this template, choose Tools | Templates
# and open the template in the editor.

class Guild < Sequel::Model
  class Visibility
    SECRET = 0
    LIMITED = 1
    FULL = 2
  end
  
  set_schema do
    primary_key :id
    String :name
    String :guild_type
    Integer :visibility, :default => Guild::Visibility::LIMITED
    
    timestamp :created_at
    timestamp :updated_on
    
  end

  validates do
    presence_of :name
    presence_of :guild_type
    presence_of :visibility
  end

  many_to_many :users
  one_to_many :guilds_users, :class => 'GuildsUsers'

  before_create :update_create_timestamp do
    self.created_at = Time.now
  end

  before_save :update_timestamps do
    self.updated_on = Time.now
  end

  def is_member?(user)
    !GuildsUsers.filter(:guild_id => id, :user_id => user.id).empty?
  end
end
