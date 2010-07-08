require 'WindowsBase'
require 'PresentationFramework'
require 'PresentationCore'
require 'System.Core, Version=3.5.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'

class GameOfLifeSimulation
  include System::Windows::Controls
  include System::Windows::Media
  include System::Windows::Shapes

  def initialize(game, width = 100, height = 100)
    @window = System::Windows::Window.new
    @window.background = Brushes.Black
    @window.width = width
    @window.height = height
    @window.resize_mode = System::Windows::ResizeMode.NoResize
    @window.title = "WPF Game of Life!"
    
    game.simulation = self
    
    update(game)
    app = System::Windows::Application.new
    app.run(@window)
  end

  def update(game)
    @grid = Grid.new
    @grid.mouse_down { game.evolve }
    
    game.size.times do
      @grid.column_definitions.add ColumnDefinition.new
      @grid.row_definitions.add RowDefinition.new
    end
    
    game.state.each_index do |row_index|
      row = game.state[row_index]
      row.each_index do |col_index|
        col = row[col_index]
        
        rect = Rectangle.new
        rect.fill = col.alive? ? Brushes.YellowGreen : Brushes.DarkGreen
        rect.stroke = Brushes.Black
        
        Grid.set_row(rect, row_index)
        Grid.set_column(rect, col_index)
        @grid.children.add(rect)
      end
    end
    
    @window.content = @grid
  end

end