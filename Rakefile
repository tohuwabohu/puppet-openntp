require 'rubygems'
require 'puppetlabs_spec_helper/rake_tasks'
require 'puppet_blacksmith/rake_tasks'
require 'puppet-lint/tasks/puppet-lint'
require 'puppet-syntax/tasks/puppet-syntax'
require 'metadata-json-lint/rake_task'
require 'voxpupuli/acceptance/rake'

exclude_paths = [
  'pkg/**/*',
  'spec/**/*',
  'vendor/**/*',
]

PuppetLint.configuration.fail_on_warnings = true
PuppetLint.configuration.ignore_paths = exclude_paths
PuppetSyntax.exclude_paths = exclude_paths
Blacksmith::RakeTask.new do |t|
  t.tag_message_pattern = "Version %s" # Signed tags must have a message
  t.tag_sign = true # enable GPG signing
end

# work around for https://github.com/voxpupuli/puppet-blacksmith/issues/57
Rake::Task["module:release"].clear
namespace :module do
  task :release => [:clean, :build, :tag, :push, :bump_commit]
end

task :test => [
  :syntax,
  :lint,
  :metadata_lint,
  :spec,
]
