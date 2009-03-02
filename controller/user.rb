# To change this template, choose Tools | Templates
# and open the template in the editor.

class UserController < Controller
  def authenticate
    if request.get?

    elsif request.post?
      if (u = User.authenticate(request[:user]['email'], request[:user]['password']))
        session[:user] = u
        if(session[:login_redirecting])
          flash[:redirected] = true
          redirect R(session[:login_redirecting][:controller], session[:login_redirecting][:action])
        else
          redirect R(NewsController, :index)
        end
      else
        @error = true
      end
    end
  end

  def create
    puts "Session user: #{session[:user].inspect}"
    @errors = {}
    if request.get?
      
    elsif request.post?
      puts "params:"
      puts request['user']
      u = User.new(request['user'])
      if !u.valid?
        @errors = u.errors
        puts @errors.inspect
      else
        u.save
        session[:user] = u
        respond "you're registered"
      end
    end
  end
end
