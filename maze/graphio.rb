require 'set'
require "minitest/autorun"

require 'simplecov'
SimpleCov.start
require 'codecov'
SimpleCov.formatter = SimpleCov::Formatter::Codecov

module GraphIO
  # Currently the module has error handling as regards the input format

  class Point
    def initialize(x, y)
      @x = x
      @y = y
    end
    def to_s
      return "#{@x} #{@y}"
    end
    def eql?(other)
      @x == other.x and @y == other.y
    end
    attr_accessor :x, :y
  end

  class Vertex
    # the status holds 0 for the starting vertex, 1 for unvisited vertices, 5 for the goal vertex
    # , the name of a path
    # or # for forbidden paths
    def initialize(obj)
      @obj = obj
      @status = "1"
      @neighbors = {}
    end
    def add(neighbor, weight=0)
      # currently it does not raise any exception in case of a cycle
      @neighbors[neighbor] = weight
    end
    def get_neighbors()
      # returns list of vertices as a comparable set
      return Set.new(@neighbors.keys)
    end
    def eql?(other)
      @obj.eql?(other.obj)
    end
    def hash
      [ obj.x, obj.y ].hash
    end
    def to_s
      return @obj.to_s
    end
    attr_accessor :status, :obj
  end
  
  class Maze
    # vertices is a dict vertex -> list of neighbor vertices
    # start
    # goal
    def initialize(file)
      # Input file format:
      # first line:max_width max_height
      # each other line corresponds to a row in a maze and each character can be
      # 0 for the starting vertex, 1 for unvisited vertices, 5 for the goal vertex
      # or # for the wall
      @vertices = {}
      dimensions = File.readlines(file)[0].split()
      max_x = dimensions[0].to_i
      max_y = dimensions[1].to_i
      @array = Array.new(max_x) { Array.new(max_y, "#") }
      File.readlines(file).drop(1).each_with_index do |line, x|
        line.strip().split("").each_with_index do |character, y|
          status = character
          if status!='#'
            p = Point.new(x,y)
            v = Vertex.new(p)
            if status=="0"
              @start = v
            elsif status=="5"
              @goal = v
            end
          end
          @array[x][y] = status
        end        
      end
      @array.each_with_index do |row, x|
        row.each_with_index do |status, y|
          if status!='#'
            p = Point.new(x,y)
            v = Vertex.new(p)
            if x+1 < max_x and @array[x+1][y]!='#'
              right = Vertex.new(Point.new(x+1,y))
              v.add(right)
            end
            if y+1 < max_y and @array[x][y+1]!='#'
              down = Vertex.new(Point.new(x,y+1))
              v.add(down)
            end
            if x-1 < max_x and @array[x-1][y]!='#'
              left = Vertex.new(Point.new(x-1,y))
              v.add(left)
            end
            if y-1 < max_y and @array[x][y-1]!='#'
              up = Vertex.new(Point.new(x,y-1))
              v.add(up)
            end                                   # we cannot move diagonal
            n = v.get_neighbors()
            @vertices[v] = n
          end
        end        
      end
    end
    def str
      result = ""
      @vertices.each do |vertex|
        result += "#{vertex.to_s}\n"
      end
      return result
    end
    def get_array_as_string()
      # @return multiline str for stdout
      result = "Start of Maze -------\n"
      @array.each do |row|
        row.each do |column|
          result << column
        end
        result << "\n"
      end
      result << "End of Maze ---------"
      return result
    end
    attr_accessor :vertices, :array, :start, :goal
  end

  class TestMaze < Minitest::Test  
    def test_input_is_parsable
      @g = Maze.new('maze/right.txt')
      assert @g.start.obj.x==1
      assert @g.start.obj.y==2
      assert @g.goal.obj.x==1
      assert @g.goal.obj.y==5
    end

    def test_initial_output_string
      @g = Maze.new('maze/right.txt')
      s = @g.get_array_as_string()            # to be displayed at terminal
      assert_equal s, """Start of Maze -------
######
##0115
######
End of Maze ---------"""
    end
  
  end
end
