# Default url mappings are:
#  a controller called Main is mapped on the root of the site: /
#  a controller called Something is mapped on: /something
# If you want to override this, add a line like this inside the class
#  map '/otherurl'
# this will force the controller to be mounted on: /otherurl

class WorksController < LoggedInController
  helper :slots

  def index
    @slot1a = slot do
      render_template 'works/your_works'
    end
    @slot1b = slot do
      render_template 'works/works_youre_reviewing'
    end
    @slot1c = slot do
      render_template 'works/group_works'
    end
    ''
  end
end
