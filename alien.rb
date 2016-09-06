class Alien

  attr_accessor :x, :y, :speed

  def initialize(window, x)
    @image = Gosu::Image.new(window, "media/alien.png", false)
    @x, @y = x, Random.rand(-21..-20)
    @speed = Random.rand(1..4)
  end

  def draw
    @image.draw_rot(@x, @y, 1, 0)
  end

  def warp(x, y)
    @x, @y = x, y
  end

  def move_down
    @y += 0.25 * @speed
  end
end