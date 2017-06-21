require 'cookstyle'
require 'rubocop/rake_task'
require 'foodcritic'

RuboCop::RakeTask.new do |rubocop|
  rubocop.options << '--display-cop-names'
end

FoodCritic::Rake::LintTask.new do |foodcritic|
  foodcritic.options = {
    progress: true,
  }
end

task default: [:rubocop, :foodcritic] do
end
