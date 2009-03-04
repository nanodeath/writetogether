# To change this template, choose Tools | Templates
# and open the template in the editor.

class Work < Sequel::Model
  
  set_schema do
    primary_key :id
    integer :user_id
    varchar :title
    varchar :file_name
    timestamp :created_at
    timestamp :updated_on
  end

  many_to_one :user

  validates do
    presence_of :user_id
    presence_of :title
    presence_of :file_name
  end

  before_save :update_timestamps do
    self.updated_on = Time.now
  end
end
