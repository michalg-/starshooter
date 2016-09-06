class Player

  attr_accessor :x, :y, :score

  def initialize(window)
    @image = Gosu::Image.new(window, "media/ship.png", false)
    @x = @y = @angle = 0.0
    @score = 0
  end

  def warp(x, y)
    @x, @y = x, y
  end

  def move(dir)
    case dir
    when :left
      @x -= 5 if can_move?(:left)
    when :right
      @x += 5 if can_move?(:right)
    when :up
      @y -= 5 if can_move?(:up)
    when :down
      @y += 5 if can_move?(:down)
    end
  end


  def draw
    @image.draw_rot(@x, @y, 1, @angle)
  end

  private
  def can_move?(direction)
    if direction == :left
      @x > 5
    elsif direction == :right
      @x < 635
    elsif direction == :up
      @y > 20
    elsif direction == :down
      @y < 460
    end
  end
end