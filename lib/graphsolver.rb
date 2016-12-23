require_relative 'graphio'
require 'set'
require "minitest/autorun"

module GraphSolver
  # Currently the module has no logging as regards the navigation  
  class QueueOrStack
    @@letter = '@'
    def initialize(start, is_queue=true)
      @obj = [start]
      @name = @@letter.next!
      @is_queue = is_queue
    end
    def add(v)
      # does not flatten the input
      if @is_queue
        @obj.unshift(v)
      else
        @obj.push(v)
      end
    end
    def remove
      item = nil
      if @is_queue
        item = @obj.shift
      else
        item = @obj.pop
      end
      return item
    end    
    def empty?
      @obj.empty?
    end    
#    attr_accessor :obj # uncomment for debugging
  end
  
  class MazeSolver
    def bfs(maze)
      # @return list of ordered list of Vertices
      vertices = QueueOrStack.new(maze.start)
      paths = QueueOrStack.new([maze.start])      # queue of lists
      solutions = []                              # list of lists
      while not vertices.empty? and solutions.length==0 # comment the last condition to get all solutions
        vertex = vertices.remove()
        path = paths.remove()
        neighbors = maze.vertices[vertex] - Set.new(path)
        neighbors.to_a.each do |neighbor|
          nextPath = path + [neighbor]
          if neighbor.eql?(maze.goal)
            solutions.push(nextPath)
          else
            vertices.add(neighbor)
            paths.add(nextPath)
          end
        end
      end
      return solutions
    end
  end
  
  class TestMazeSolver < Minitest::Test  
    def test_right
      g = GraphIO::Maze.new('maze/right.txt')
      solver = MazeSolver.new()
      solutions = solver.bfs(g)
      assert solutions.length==1, solutions.length
      x = ""
      solutions[0].each do |vertex|
        x += vertex.to_s + "\n"
      end
      assert x == "1 2\n1 3\n1 4\n1 5\n", x
    end
    
    def test_right_left
      g = GraphIO::Maze.new('maze/right-left.txt')
      solver = MazeSolver.new()
      solutions = solver.bfs(g)
      assert solutions.length==1, solutions.length
      x = ""
      solutions[0].each do |vertex|
        x += vertex.to_s + "\n"
      end
      assert x == "1 2\n1 3\n2 3\n2 4\n2 5\n3 5\n3 6\n3 7\n3 8\n", x
    end
    
    def test_up
      g = GraphIO::Maze.new('maze/up.txt')
      solver = MazeSolver.new()
      solutions = solver.bfs(g)
      assert solutions.length==1, solutions.length
      x = ""
      solutions[0].each do |vertex|
        x += vertex.to_s + "\n"
      end
      assert x == "1 2\n1 3\n1 4\n2 4\n2 5\n2 6\n1 6\n1 7\n1 8\n", x
    end

  end
end
