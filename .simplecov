SimpleCov.start do
  FileUtils.rm_rf 'coverage'

  refuse_coverage_drop
  add_filter '/spec/'
  add_filter '/features/'
end
