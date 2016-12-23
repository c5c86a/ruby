require_relative 'graphsolver'


g = GraphIO::Maze.new('sample_input.txt')
solver = GraphSolver::MazeSolver.new()
solutions = solver.bfs(g)
solutions[0].each do |vertex|
  puts vertex.to_s
end
