require_relative 'graphio'
require 'set'

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
  
end
