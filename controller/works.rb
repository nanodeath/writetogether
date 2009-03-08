# Default url mappings are:
#  a controller called Main is mapped on the root of the site: /
#  a controller called Something is mapped on: /something
# If you want to override this, add a line like this inside the class
#  map '/otherurl'
# this will force the controller to be mounted on: /otherurl

class WorksController < LoggedInController
  helper :slots

  def index
    @your_works = Work.filter(:user_id => session[:user].id).limit(5)
    @slot1a = render_template 'your_works'
    
    @slot1b = slot do
      render_template 'works/works_youre_reviewing'
    end
    @slot1c = slot do
      render_template 'works/group_works'
    end
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
    @slot1a = render_template 'show_details'
  end

  def update(id)
    return unless request.post?
    w = Work[id]
    if(w and w.update(request['work']))
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
end
