require 'enablecov'

  class TestMazeSolver < Minitest::Test  
    def test_right
      g = GraphIO::Maze.new('test/data/right.txt')
      solver = GraphSolver::MazeSolver.new()
      solutions = solver.bfs(g)
      assert solutions.length==1, solutions.length
      x = ""
      solutions[0].each do |vertex|
        x += vertex.to_s + "\n"
      end
      assert x == "1 2\n1 3\n1 4\n1 5\n", x
    end
    
    def test_right_left
      g = GraphIO::Maze.new('test/data/right-left.txt')
      solver = GraphSolver::MazeSolver.new()
      solutions = solver.bfs(g)
      assert solutions.length==1, solutions.length
      x = ""
      solutions[0].each do |vertex|
        x += vertex.to_s + "\n"
      end
      assert x == "1 2\n1 3\n2 3\n2 4\n2 5\n3 5\n3 6\n3 7\n3 8\n", x
    end
    
    def test_up
      g = GraphIO::Maze.new('test/data/up.txt')
      solver = GraphSolver::MazeSolver.new()
      solutions = solver.bfs(g)
      assert solutions.length==1, solutions.length
      x = ""
      solutions[0].each do |vertex|
        x += vertex.to_s + "\n"
      end
      assert x == "1 2\n1 3\n1 4\n2 4\n2 5\n2 6\n1 6\n1 7\n1 8\n", x
    end

  end


