#!/usr/bin/env rake

require 'bundler'
Bundler::GemHelper.install_tasks

require 'rake/clean'
require 'rspec/core/rake_task'

namespace :spec do
  begin
    require 'cane/rake_task'
    desc "Run cane to check quality metrics"
    Cane::RakeTask.new(:quality) do |cane|
      cane.abc_max = 10
      cane.add_threshold 'coverage/covered_percent', :>=, 74
      cane.no_style = true
      cane.abc_exclude = %w(Middleman::Imageoptim::Optimizer#optimizer)
    end

    task :default => :quality
  rescue LoadError
    warn "cane not available, quality task not provided."
  end

  desc 'Run unit specs'
  RSpec::Core::RakeTask.new(:unit) do |spec|
    spec.pattern = "spec/unit/*_spec.rb"
    spec.rspec_opts = "--require spec_helper"
  end
end

desc 'Default: run unit tests.'
task :default => ['spec:unit']
