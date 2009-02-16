# To change this template, choose Tools | Templates
# and open the template in the editor.
require 'fiber'

class NewsController < LoggedInController
  helper :bench
  helper :slots

  def index
    #puts Ramaze::Action.current.controller
    @slot1a = slot do
      #puts Ramaze::Action.current.controller
      render_template 'news/blog_latest5'
    end
    @slot1b = slot do
      render_template 'news/wrote_something_new'
    end
    @slot1c = slot do
      render_template 'news/met_new_people'
    end
    @slot2a = slot do
      render_template 'news/read_some_works'
    end
    Thread.pass

    "foo"
  end
end

