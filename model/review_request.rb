# To change this template, choose Tools | Templates
# and open the template in the editor.

class ReviewRequest < Sequel::Model
  set_schema do
    primary_key :id
    foreign_key :work_id, :works
    foreign_key :recipient_id, :user
    String :message
    String :response
    var_char :file_name

    boolean :work_deleted, :default => false

    timestamp :created_at
    timestamp :updated_on
  end

  many_to_one :work
  many_to_one :recipient, :class => 'User' #, :foreign_key => :recipient_id

  before_create :update_create_timestamp do
    self.created_at = Time.now
  end

  before_save :update_timestamps do
    self.updated_on = Time.now
  end

  def url
    "/review_requests/#{file_name}"
  end
end
