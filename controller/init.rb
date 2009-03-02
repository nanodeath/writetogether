# Define a subclass of Ramaze::Controller holding your defaults for all
# controllers

class Controller < Ramaze::Controller
  layout '/page'
  helper :flash, :xhtml
  engine :Haml
end

class LoggedInController < Controller
  layout '/logged_in'
  helper :aspect
  before_all do
    login_required unless ['login'].include? Action.current.method
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

# Here go your requires for subclasses of Controller:
require 'controller/main'
require 'controller/news'
require 'controller/circle'
require 'controller/works'
require 'controller/badges'
require 'controller/forum'
require 'controller/resources'
require 'controller/user'