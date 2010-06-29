require File.join(File.dirname(__FILE__), 'game_of_life')
require 'rubygems'
require 'spec'
require 'spec/autorun'

describe GameOfLife do

  before(:each) do
    @game = GameOfLife.new(3)
  end

  it "returns the board state after evolving" do
    empty_board = [ [0,0,0], [0,0,0], [0,0,0] ]
    @game.state = empty_board
    @game.evolve.should == empty_board
  end
  
  it "kills a cell if it has no live neighbours" do
    @game.state = [ [1,0,0], [0,0,0], [0,0,0] ]
    @game.evolve
    @game.state[0][0].should be_dead
    @game.should be_extinct
  end
  
  it "kills a cell if it only has one live neighbour" do
    @game.state = [ [0,0,0], [1,0,0], [1,0,0] ]
    @game.evolve
    @game.state[1][0].should be_dead
    @game.state[2][0].should be_dead
    @game.should be_extinct
  end
  
  it "kills a cell if surrounding area is overpopulated" do
    @game.state = [ [1,1,1], [1,1,1], [1,1,1] ]
    @game.evolve
    @game.should be_extinct
  end
  
  it "births a new cell if it is surrounded by exactly 3 neighbours" do
    @game.state = [ [1,0,0], [1,1,0], [0,0,0] ]
    @game.evolve
    @game.state.should == [ [1,1,1], [1,1,1], [1,1,1] ]
  end

  it "maintains population if it is surrounded by 2 or 3 neighbours" do
    @game.state = [ [0,1,1], [1,0,0], [1,0,0] ]
    lambda {
      @game.evolve
    }.should_not change(@game, :state)
  end
  
  it "expands to a 5x5 matrix" do
    @game = GameOfLife.new(5)
    @game.state = [ [0,1,1,0,0], [0,1,0,0,1], [1,1,0,0,1], [1,1,0,1,0], [1,1,0,0,1] ]
    @game.evolve
    @game.state.should == [ [0,0,1,1,1], [0,0,0,1,1], [0,0,0,1,0], [0,0,0,1,0], [0,0,0,1,1] ]
  end
  
  it "expands to a 15x15 matrix" do
    @game = GameOfLife.new(15)
    # this test data is correct, I promise :)
    @game.state = [
      [1,0,0,1,0,1,0,1,1,1,0,1,0,1,1],
      [1,1,0,1,1,1,1,0,1,1,1,1,1,1,0],
      [0,0,0,0,1,1,0,0,1,0,1,1,0,0,0],
      [0,1,1,0,0,0,0,1,0,0,0,1,1,0,1],
      [0,1,1,0,1,1,1,1,0,0,1,0,0,1,1],
      [1,0,1,1,0,0,0,0,1,1,0,0,1,1,1],
      [1,0,0,0,0,0,0,1,0,0,0,1,0,1,0],
      [0,0,0,0,0,0,0,0,1,1,1,1,0,0,1],
      [1,0,1,0,1,1,0,0,0,0,1,0,0,0,1],
      [1,1,1,1,0,1,0,1,0,1,1,1,1,1,0],
      [1,0,1,0,0,0,0,1,1,0,0,1,0,1,0],
      [1,1,0,0,0,0,0,1,0,0,1,0,1,0,1],
      [1,0,1,0,1,0,1,1,1,0,1,0,1,1,1],
      [0,1,0,1,0,1,0,1,1,0,1,0,1,1,1],
      [0,1,0,0,1,0,0,0,0,0,1,1,0,1,0]
    ]
    @game.evolve
    @game.state.should == [
      [0,0,0,1,0,0,0,1,0,0,0,0,0,0,0],
      [1,1,1,1,0,0,0,0,0,0,0,0,0,1,0],
      [0,0,0,0,0,0,0,0,1,0,0,0,0,0,1],
      [0,1,1,0,0,0,0,1,1,1,0,0,1,0,1],
      [0,0,0,0,1,1,1,1,0,1,1,0,0,0,0],
      [0,0,1,1,1,1,0,0,1,1,1,1,0,0,0],
      [1,1,0,0,0,0,0,1,0,0,0,1,0,0,0],
      [0,1,0,0,0,0,0,0,1,1,0,1,1,1,0],
      [0,0,1,0,1,1,1,0,0,0,0,0,0,0,0],
      [0,0,0,0,0,1,0,1,0,1,0,0,0,1,0],
      [0,0,0,1,0,0,0,1,0,0,0,0,0,0,0],
      [0,0,1,1,0,0,0,0,0,0,1,0,0,0,0],
      [0,0,1,1,1,1,0,0,0,0,1,0,0,0,0],
      [0,1,0,1,0,1,0,0,1,0,1,0,0,0,0],
      [0,1,0,1,0,1,0,0,0,0,0,0,0,0,0]
    ]
  end
  
end
