class Star

  attr_accessor :x, :y

  def initialize(window, y = rand(480))
    @image = Gosu::Image.new(window, "media/star.png", false)
    @x = rand(640)
    @y = y
    @speed = Random.rand(0.1..3)
  end

  def draw
    @image.draw_rot(@x, @y, 1, 0)
  end

  def move_down
    @y += @speed
  end

end