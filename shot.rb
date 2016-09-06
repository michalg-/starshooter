class Shot
  attr_accessor :x, :y

  def initialize(window, x, y)
    @image = Gosu::Image.new(window, "media/shot.png", false)
    @x = x
    @y = y
  end

  def draw
    @image.draw_rot(@x, @y, 1, 0)
  end

  def move_up
    @y -= 5
  end

  def check_shot(aliens, shots, player)
    if aliens.reject! {|alien| Gosu::distance(@x, @y, alien.x, alien.y) < 20 }
      shots.reject! {|shot| shot == self}
      player.score += 1
    end
  end
end