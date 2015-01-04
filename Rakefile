#!/usr/bin/env rake

require 'bundler'
Bundler::GemHelper.install_tasks

require 'rake/clean'
require 'rspec/core/rake_task'
require 'cucumber'
require 'cucumber/rake/task'

namespace :spec do
  desc 'Run unit specs'
  RSpec::Core::RakeTask.new(:unit) do |config|
    config.pattern = 'spec/unit/*_spec.rb'
    config.rspec_opts = '--require spec_helper'
  end

  desc 'Run feature tests'
  Cucumber::Rake::Task.new(:features) do |config|
    config.cucumber_opts = 'features --format pretty'
  end
end

desc 'Default: run the tests.'
task default: ['spec:unit', 'spec:features']
