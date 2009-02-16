# Default url mappings are:
#  a controller called Main is mapped on the root of the site: /
#  a controller called Something is mapped on: /something
# If you want to override this, add a line like this inside the class
#  map '/otherurl'
# this will force the controller to be mounted on: /otherurl

class MainController < Controller
  # the index action is called automatically when no other action is specified
  def index
    if(false)
      redirect Rs :home
    end
  end

  # for the signed in user
  def home
    if(false)
      redirect Rs :index
    end
  end
  
  def login
    if request.get?
      @title = "WriteTogether - Sign In"
      "signin page"
    elsif request.post?
      @title =  "WriteTogether - Sign In - Posted!"
      puts request.params.inspect
      if User.authenticate(request.params['email'], request.params['password'])
        puts "yay, it worked"
      else
        puts "boo, you suck"
      end
    end
  end
  
  def register
    "register page"
  end

end
