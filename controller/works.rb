# Default url mappings are:
#  a controller called Main is mapped on the root of the site: /
#  a controller called Something is mapped on: /something
# If you want to override this, add a line like this inside the class
#  map '/otherurl'
# this will force the controller to be mounted on: /otherurl

class WorksController < LoggedInController
  def index
    @your_works = session[:user].latest_works

    @review_requests_i_sent = []
    
    session[:user].works.each do |work|
      @review_requests_i_sent += work.review_requests
    end

    @review_requests_i_received = ReviewRequest.filter(:recipient_id => session[:user].id)
    

    @slot1a = render_template 'your_works'
    
    @slot1b = render_template 'works_youre_reviewing'
    @slot1c = render_template 'group_works'
    ''
  end

  def your(id=nil)
    if id.nil?
      @your_works = Work.filter(:user_id => session[:user].id)
      @slot1a = render_template 'your_all'
    else

    end
  end

  def show(id)
    @work = Work[id]
    if @work.user == session[:user]
      @feedback = ReviewRequest.filter(:work_id => id).order_by(:updated_on)

      @slot1b = render_template 'edit_details'

      @peers = session[:user].get_peers
      @slot1c = render_template 'send_to_peer'
    else
      @rr = ReviewRequest.find(:recipient_id => session[:user].id, :work_id => id)
    end
    @slot1a = render_template 'show_details'
  end

  def update(id)
    return unless request.post?
    w = Work[id]
    if(w and w.user == session[:user] and w.update(request['work']))
      flash[:info] = 'Saved successfully'
    else
      flash[:info] = 'Save failed'
    end
    redirect(Rs(:show, id))
  end

  def upload
    if request.post?
      tempfile, filename, @type = request[:file].values_at(:tempfile, :filename, :type)
      @extname, @basename = File.extname(filename), File.basename(filename)
      @file_size = tempfile.size

      if request[:file]
        FileUtils.move(tempfile.path, File::join(Ramaze::Global.public_root, "works", @basename))
        w = Work.new(:title => request[:title], :file_name => @basename)
        w.user_id = session[:user].id
        if w.valid?
          w.save
          redirect R(WorksController, :index)
        else
          respond "oops, you missed a field"
        end
      else
        respond "oops, you forgot a file"
      end
    elsif request.get?
    end
  end

  def send_to_peer
    begin
      raise "invalid_request" unless request.post?
      rr = ReviewRequest.new(request['review_request'])
      work = Work[rr.work_id]
      recipient = User[rr.recipient_id]
      raise "invalid_request" unless
      work and # work is valid
      work.user == session[:user] and # owner of work is logged in user
      recipient and # recipient is a valid user
      recipient != session[:user] and # recipient is not logged in user
      session[:user].in_guild_with?(work.user) # recipient is in guild with user
      if rr.valid?
        rr.save
        flash[:info] = "Review request sent! #{recipient.name} has the request now."
      else
        flash[:error] = "Review request not sent because an error occurred."
        @errors = rr.errors
      end
    rescue Exception => e
      raise unless e.message =~ /invalid_request/
      flash[:info] = "Invalid request."
    end
    redirect Rs(:index)
  end

  # What the peer posts back
  def send_to_peer_response
    begin
      puts request[:review_request].inspect
      raise "invalid_request" unless request.post?
      rr = ReviewRequest[request[:review_request]['id']]
      raise "invalid_request" if rr.nil? or rr.recipient_id != session[:user].id
      if (!request[:review_request]['file_name'].empty?)
        tempfile, filename, @type = request[:review_request]['file_name'].values_at(:tempfile, :filename, :type)
        @extname, @basename = File.extname(filename), File.basename(filename)
        @file_size = tempfile.size

        FileUtils.move(tempfile.path, File::join(Ramaze::Global.public_root, "review_requests", @basename))
        request[:review_request]['file_name'] = @basename
      end
      request['review_request'].delete_if {|k,v| !['file_name', 'response'].include?(k)}
      rr.update(request['review_request'])
      flash[:info] = "Your response has been submitted."
      redirect Rs(:show, rr.id)
    rescue Exception => e
      raise e unless e.message =~ /invalid_request/
      flash[:info] = "Invalid request"
    end
  end
end
