task :console do
  require 'pry'
  Dir["lib/**/*.rb"].each { |f| require File.expand_path(f) }
  ARGV.clear
  Pry.start
end
