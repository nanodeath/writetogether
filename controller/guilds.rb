# Default url mappings are:
#  a controller called Main is mapped on the root of the site: /
#  a controller called Something is mapped on: /something
# If you want to override this, add a line like this inside the class
#  map '/otherurl'
# this will force the controller to be mounted on: /otherurl

class GuildsController < LoggedInController
  helper :slots
  
  def index
    #@layout = :regular
    #@content = 'foo'
    @your_guilds = session[:user].guilds
    Ramaze::Log.info(@your_guilds.inspect)
    @slot1a = render_template 'your_guilds'
    @slot1b = render_template 'guild_operations'
  end

  def show(id)
    id = id.to_i
    @guild = Guild[id]
    if(@guild.nil? || (@guild.visibility == Guild::Visibility::SECRET && !@guild.is_member?(session[:user])))
      flash[:info] = "DENIED"
      redirect Rs(:index)
    end
    @members = []
    guild_users = GuildsUsers.eager(:user).filter(:guild_id => id).all
    guild_users.sort do |gu1, gu2|
      if gu1.connection == gu2.connection
        gu1.user.name <=> gu2.user.name
      else
        gu2.connection <=> gu1.connection
      end
    end.each do |gu|
      @members << [gu.connection, gu.user]
    end
    @slot1a = render_template 'members'

    @slot1b = render_template 'shoutbox'
    @slot2a = render_template 'works_needing_input'
    @slot2b = render_template 'joint_efforts'
  end

  def create
    if request.post?
      guild = Guild.new(request['guild'])
      if guild.valid?
        guild.save
        Ramaze::Log.info("primary_key_restricted? " + GuildsUsers.restrict_primary_key?.to_s)
        gu = GuildsUsers.new(:guild_id => guild.id, :user_id => session[:user].id, :connection => GuildsUsers::Connection::CREATOR)
        if gu.valid?
          gu.save
          flash[:info] = "Guild #{guild.name} created and displayed"
          redirect Rs(:show, guild.id)
        else
          @errors = gu.errors
        end
        
      else
        @errors = guild.errors
      end
    end
  end
end
