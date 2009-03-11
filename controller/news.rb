# To change this template, choose Tools | Templates
# and open the template in the editor.
require 'fiber'

class NewsController < LoggedInController
  def index
    @slot1a = render_template 'blog_latest5'
    @slot1b = render_template 'wrote_something_new'
    @slot1c = render_template 'met_new_people'
    @slot2a = render_template 'read_some_works'
  end
end

