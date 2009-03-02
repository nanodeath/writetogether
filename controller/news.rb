# To change this template, choose Tools | Templates
# and open the template in the editor.
require 'fiber'

class NewsController < LoggedInController
  helper :bench
  helper :slots

  def index
    #puts Ramaze::Action.current.controller
    @slot1a = render_template 'blog_latest5'
    @slot1b = render_template 'wrote_something_new'
    @slot1c = render_template 'met_new_people'
    @slot2a = render_template 'read_some_works'

    "foo"
  end
end

