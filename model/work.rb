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
    Integer :visibility, :default => 0 # 2 is all, 1 is guild, 0 is private
  end

  many_to_one :user
  one_to_many :review_requests

  validates do
    presence_of :user_id
    presence_of :title
    presence_of :file_name
  end

  before_create :update_create_timestamp do
    self.created_at = Time.now
  end

  before_save :update_timestamps do
    self.updated_on = Time.now
  end

  def url
    "/works/#{file_name}"
  end
end
