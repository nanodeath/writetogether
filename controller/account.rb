# To change this template, choose Tools | Templates
# and open the template in the editor.

class AccountController < LoggedInController
  def my
    @user = session[:user]
    @slot1a = render_template 'edit'
  end

  def update
    return unless request.post?
    changed_email = false
    if(session[:user].email != request['user']['email'])
      old_email = session[:user].email
      new_email = request['user'].delete 'email'
      changed_email = true
    end
    if session[:user].set(request['user']) && session[:user].save_changes
      flash[:info] = 'Account updated!'
      flash[:info] += " Except for 'email'.  Check your inbox." if changed_email
    else
      flash[:info] = 'Account not updated!'
    end
    
    redirect Rs(:my)
  end

  def index(id=nil)
    redirect Rs(:show, id) if !id.nil?
  end

  def show(id)
    logged_in_user = session[:user]
    looked_up_user = User[id]

    if can_view_profile?(logged_in_user, looked_up_user)
      @current_user = session[:user]
      @user = looked_up_user
    else
      flash[:info] = "You can't view that profile page."
      redirect Rs(:show, logged_in_user.id)
    end
    @slot1a = render_template "show"
  end

  protected
  def can_view_profile?(source_user, target_user)
    Ramaze::Log.info("1")
    return false if source_user.nil? or target_user.nil?
    Ramaze::Log.info("2")
    return true if target_user.profile_visibility == User::Visibility::ALL # anyone can see profile
    Ramaze::Log.info("3")
    return true if source_user == target_user # is same user
    Ramaze::Log.info("4")
    return true if target_user.profile_visibility == User::Visibility::GUILD and
      source_user.in_guild_with?(target_user) # in guild together
    return false
  end
end
