Then(/^the file "(.*?)" should be (\d+) bytes$/) do |img, size|
  File.size(File.join(current_dir,img)).should == size.to_i
end

Then(/^the manifest should have the right timestamp for "(.*?)"$/) do |file|
  manifest = YAML::load( File.open(manifest_path).read )
  file_stamp = File.mtime( File.join(current_dir,file) )
  puts file
  puts manifest
  manifest[file].should == file_stamp
end

Given(/^a primed manifest for "(.*?)"$/) do |file|
  manifest = { file => File.mtime( File.join(current_dir,file) ) }
  File.open(manifest_path, 'w') {|f| f.write(YAML::dump(manifest)) }
end

Given(/^some time has passed$/) do
  # this needs to be > 1 to get out of the single second resolution of a file timestamp
  sleep(1.5)
end

Given(/^an updated file at "(.*?)"$/) do |file|
  FileUtils.touch File.join(current_dir, file)
end

Then /^the file "([^\"]*)" should have been updated$/ do |file|
  target = File.join(current_dir, file)
  File.mtime(target).should_not == @modification_times[target]
end

def manifest_path
  File.join(current_dir,'build','imageoptim.manifest.bin')
end
