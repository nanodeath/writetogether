# Default url mappings are:
#  a controller called Main is mapped on the root of the site: /
#  a controller called Something is mapped on: /something
# If you want to override this, add a line like this inside the class
#  map '/otherurl'
# this will force the controller to be mounted on: /otherurl

class CircleController < LoggedInController
  helper :slots
  
  def index
    @slot1a = slot do
      render_template 'circle/members'
    end
    @slot1b = slot do
      render_template 'circle/shoutbox'
    end
    @slot2a = slot do
      render_template 'circle/works_needing_input'
    end
    @slot2b = slot do
      render_template 'circle/joint_efforts'
    end
    ''
  end
end
