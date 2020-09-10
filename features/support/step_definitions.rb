require 'aruba/api'

Then(/^the file "(.*?)" should be (\d+) bytes$/) do |img, size|
  expect(File.size(File.join(expand_path("."), img))).to eql(size.to_i)
end

Then(/^the file "(.*?)" should be less than (\d+) bytes$/) do |img, size|
  expect(File.size(File.join(expand_path("."), img))).to be < size.to_i
end

Then(/^the manifest should have the right timestamp for "(.*?)"$/) do |file|
  manifest = YAML.load(File.read(manifest_path))
  file_stamp = File.mtime(File.join(expand_path("."), file))
  expect(manifest[file]).to eql(file_stamp)
end

Given(/^a primed manifest for "(.*?)"$/) do |file|
  manifest = { file: File.mtime(File.join(expand_path("."), file)) }
  File.open(path, 'w') do |manifest_file|
    manifest_file.write(YAML.dump(manifest))
  end
end

Given(/^some time has passed$/) do
  # this needs to be > 1 to get out of the single second resolution of a
  # file timestamp
  sleep(1.5)
end

Given(/^an updated file at "(.*?)"$/) do |file|
  FileUtils.touch(File.join(expand_path("."), file))
end

Given(/^the file "([^"]*)" has mode "([^"]*)"$/) do |file_name, file_mode|
  filesystem_permissions(file_mode, file_name)
end

Then(/^the file "([^\"]*)" should have been updated$/) do |file|
  target = File.join(expand_path("."), file)
  expect(File.mtime(target)).not_to eql(@modification_times[target])
end

def manifest_path
  File.join(expand_path("."), 'build', 'imageoptim.manifest.yml')
end
