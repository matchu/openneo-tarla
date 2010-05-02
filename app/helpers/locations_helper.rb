module LocationsHelper
  def world_logo(world)
    if world == 'Moltara'
      'http://images.neopets.com/items/mcf_fireeggs.gif'
    else
      "http://images.neopets.com/altador/altadorcup/team_logos/#{world.downcase}_50.gif"
    end
  end
end
