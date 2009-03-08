class LoggedInController < Controller
  layout '/logged_in'
  helper :aspect
  before_all do
    #login_required
#    if false
    general_methods = [:login]
    login_required unless general_methods.include? Action.current.method.to_sym
#    specific_methods = {UserController => [:authenticate, :create]}
#    unless general_methods.include? Action.current.method.to_sym
#      unless specific_methods.key?(Controller.current.class) &&
#          specific_methods[Controller.current.class].include?( Action.current.method.to_sym)
#        login_required
#      end
#    end
#    end
  end

  private
  def logged_in?
    not session[:user].nil?
  end

  def login_required
    if !logged_in?
      session[:login_redirecting] = {
        :controller => Controller.current,
        :action => Ramaze::Action.current.method.to_sym
      }
      redirect R(UserController, :authenticate)
    end
  end
end