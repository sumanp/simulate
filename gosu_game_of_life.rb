#Gosu File
require 'gosu'
require_relative 'world.rb'

class GameOfLifeWindow < Gosu::Window
  def initialize(height=800, width=600)
    @height = height
    @width = width
    super height, width, false
    self.caption = "Conway's Game of Life for CF"

    #color
    @background_color = Gosu::Color.new(0xffdedede)
    @alive = Gosu::Color.new(0xff121212)
    @dead = Gosu::Color.new(0xffededed)

    #Game instance
    @cols = width/15
    @rows = height/15

    @col_width = width/@cols
    @row_height = height/@rows

    @world = World.new(@cols, @rows)
    @game = Game.new(@world)
    @game.world.randomly_populate
  end

  def update
    @game.tick!
  end

  def draw
    draw_quad(0, 0, @background_color,
              width, 0, @background_color,
              width, height, @background_color,
              0, height, @background_color)

    @game.world.cells.each do |cell|
      if cell.alive?
        draw_quad(cell.x * @col_width, cell.y * @row_height, @alive,
                  cell.x * @col_width + (@col_width - 1), cell.y * @row_height, @alive,
                  cell.x * @col_width + (@col_width - 1), cell.y * @row_height + (@row_height - 1), @alive,
                  cell.x * @col_width, cell.y * @row_height + (@row_height - 1), @alive)
      else
        draw_quad(cell.x * @col_width, cell.y * @row_height, @dead,
                  cell.x * @col_width + (@col_width - 1), cell.y * @row_height, @dead,
                  cell.x * @col_width + (@col_width - 1), cell.y * @row_height + (@row_height - 1), @dead,
                  cell.x * @col_width, cell.y * @row_height + (@row_height - 1), @dead)
      end
    end
  end

  def needs_cursor?
    true
  end

  window = GameOfLifeWindow.new
  window.show
end
