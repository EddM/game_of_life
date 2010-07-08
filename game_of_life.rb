# GameOfLife.rb
# Entry for http://rubylearning.com/blog/2010/06/28/rpcfn-the-game-of-life-11/
#
# Edd Morgan <eddm@me.com>
#

class GameOfLife
  attr_accessor :state, :simulation, :size
  
  def initialize(size = 3)
    @size = size
  end
  
  def evolve
    new_state = []
    
    row = 0
    while row < @size 
      this_row = []
      
      col = 0
      while col < @size
        living_neighbours = 0
        
        #right
        if col < (@size - 1) && @state[row][col + 1].alive?
          living_neighbours += 1
        elsif col == (@size - 1) && @state[row][0].alive?
          living_neighbours += 1
        end
        
        #left
        if col > 0 && @state[row][col - 1].alive?
          living_neighbours += 1
        elsif col == 0 && @state[row][(@size - 1)].alive?
          living_neighbours += 1
        end
        
        #up
        if row > 0 && @state[row - 1][col].alive?
          living_neighbours += 1
        elsif row == 0 && @state[(@size - 1)][col].alive?
          living_neighbours += 1
        end
        
        #down
        if row < (@size - 1) && @state[row + 1][col].alive?
          living_neighbours += 1
        elsif row == (@size - 1) && @state[0][col].alive?
          living_neighbours += 1
        end
        
        if row == 0
          if col == (@size - 1)
            living_neighbours += 1 if @state[(@size - 1)][0].alive? 
          else
            living_neighbours += 1 if @state[(@size - 1)][col + 1].alive?
          end
          
          if col == 0
            living_neighbours += 1 if @state[(@size - 1)][(@size - 1)].alive?
          else
            living_neighbours += 1 if @state[(@size - 1)][col - 1].alive?
          end
        else
          if col == (@size - 1)
            living_neighbours += 1 if @state[row - 1][0].alive? #top right
          else
            living_neighbours += 1 if @state[row - 1][col + 1].alive? #top right
          end
          
          if col == 0
            living_neighbours += 1 if @state[row - 1][(@size - 1)].alive? # top left
          else
            living_neighbours += 1 if @state[row - 1][col - 1].alive? #top left
          end
        end
        
        if row == (@size - 1)
          if col == (@size - 1)
            living_neighbours += 1 if @state[0][0].alive? # bottom right
          else
            living_neighbours += 1 if @state[0][col + 1].alive? # bottom right
          end
          
          if col == 0
            living_neighbours += 1 if @state[0][(@size - 1)].alive? # bottom left
          else
            living_neighbours += 1 if @state[0][col - 1].alive?
          end
        else
          if col == (@size - 1)
            living_neighbours += 1 if @state[row + 1][0].alive? # bottom right
          else
            living_neighbours += 1 if @state[row + 1][col + 1].alive? # bottom right
          end
          
          if col == 0
            living_neighbours += 1 if @state[row + 1][(@size - 1)].alive? # bottom left
          else
            living_neighbours += 1 if @state[row + 1][col - 1].alive? # bottom left
          end
        end
        
        if !@state[row][col].alive?
          this_row << (living_neighbours == 3 ? 1 : 0)
        else
          this_row << ((living_neighbours == 2 || living_neighbours == 3) ? 1 : 0)
        end
        
        col += 1
      end
      
      new_state << this_row
      row += 1
    end
  
    @state = new_state
    @simulation.update(self) if @simulation
  end
  
  def extinct?
    @state.each do |row|
      row.each do |cell|
        return false if cell.alive?
      end
    end
    
    true
  end
  
  def self.random_board(size = 3)
    board = []
    size.times do
      row = []
      size.times do
        row << rand(2)
      end
      board << row
    end
    
    board
  end
  
end 

Fixnum.class_eval do
  define_method :alive? do
    self == 1
  end
  define_method :dead? do
    !alive?
  end
end 