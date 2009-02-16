# Default url mappings are:
#  a controller called Main is mapped on the root of the site: /
#  a controller called Something is mapped on: /something
# If you want to override this, add a line like this inside the class
#  map '/otherurl'
# this will force the controller to be mounted on: /otherurl

class ForumController < LoggedInController
  helper :slots
#  helper :user
#  helper :auth

  

  def index
    @slot1a = slot do
      puts "user:" + user.inspect
      render_template 'badges/alignment'
    end
    ''
  end

  private

  def login_required
    flash[:error] = 'login required to view that page' unless logged_in?
    super
  end

  def check_auth user, pass
    return false if (not user or user.empty?) and (not pass or pass.empty?)

    if User[:username => user, :password => pass].nil?
      flash[:error] = 'invalid username or password'
      false
    else
      true
    end
  end
end
