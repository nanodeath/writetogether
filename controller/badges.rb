# Default url mappings are:
#  a controller called Main is mapped on the root of the site: /
#  a controller called Something is mapped on: /something
# If you want to override this, add a line like this inside the class
#  map '/otherurl'
# this will force the controller to be mounted on: /otherurl

class BadgesController < LoggedInController
  helper :slots
  
  def index
    @slot1a = slot do
      render_template 'badges/alignment'
    end
    @slot1b = slot do
      render_template 'badges/reviewer_badges'
    end
    @slot1c = slot do
      render_template 'badges/reviewer_antibadges'
    end

    @slot2c = slot do
      render_template 'badges/author_badges'
    end
    @slot2d = slot do
      render_template 'badges/author_antibadges'
    end
    ''
  end
end
