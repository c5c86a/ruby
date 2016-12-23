require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs << "maze"
  t.test_files = FileList['maze/*.rb']
  t.verbose = true
end

task :default => [:test]
