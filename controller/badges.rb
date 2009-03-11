# Default url mappings are:
#  a controller called Main is mapped on the root of the site: /
#  a controller called Something is mapped on: /something
# If you want to override this, add a line like this inside the class
#  map '/otherurl'
# this will force the controller to be mounted on: /otherurl

class BadgesController < LoggedInController
  
  def index
    @slot1a = render_template 'alignment'
    @slot1b = render_template 'reviewer_badges'
    @slot1c = render_template 'reviewer_antibadges'

    @slot2c = render_template 'author_badges'
    @slot2d = render_template 'author_antibadges'
  end
end
