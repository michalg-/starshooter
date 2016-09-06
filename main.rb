require 'gosu'
require_relative 'alien.rb'
require_relative 'player.rb'
require_relative 'shot.rb'
require_relative 'star.rb'

module ZOrder
  Background, Stars, Shots, Player, Alien, UI = *0..5
end

class GameWindow < Gosu::Window

  def initialize
    super(640, 480, false)
    self.caption = "Gosu Tutorial Game"

    @font = Gosu::Font.new(self, Gosu::default_font_name, 10)

    @aliens = []
    @shots = []
    @stars = []


    100.times do
      @stars.push(Star.new(self))
    end

    @player = Player.new(self)
    6.times do
      @aliens.push(Alien.new(self, Random.rand(20..620)))
    end
    @player.warp(320, 450)
  end

  def update
    if button_down? Gosu::KbLeft or button_down? Gosu::GpLeft then
      @player.move(:left)
    end
    if button_down? Gosu::KbRight or button_down? Gosu::GpRight then
      @player.move(:right)
    end
    if button_down? Gosu::KbDown or button_down? Gosu::GpDown then
      @player.move(:down)
    end
    if button_down? Gosu::KbUp or button_down? Gosu::GpUp then
      @player.move(:up)
    end

    @shots.each { |shot| shot.check_shot(@aliens, @shots, @player)}
    @shots.each {|s| s.move_up}
    @shots.reject!{|shot| shot.y < -5}

    if @aliens.size < 6
      @aliens.push(Alien.new(self, Random.rand(20..620)))
    end
    @aliens.each {|alien| alien.move_down}

    @stars.each {|star| star.move_down}
    if @stars.reject!{|star| star.y > 480}
      @stars.push(Star.new(self, 0))
    end

    @player.score -= 5 if @aliens.reject!{|alien| alien.y > 500}
  end

  def draw
    @shots.each {|s| s.draw}
    @stars.each {|s| s.draw}
    @aliens.each {|a| a.draw}
    @player.draw
    @font.draw("Punkty: #{@player.score}", 10, 10, ZOrder::UI, 1.0, 1.0, 0xffffff00)
  end

  def button_down(id)
    close if id == Gosu::KbEscape
    @shots.push(Shot.new(self, @player.x, @player.y - 30)) if id == Gosu::KbSpace
  end
end

window = GameWindow.new
window.show
