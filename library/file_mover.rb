require_relative 'CONSTANTS'
require 'fileutils'

def directory_exists? (directory)
  return File.directory?(directory)
end

def check_directory_structure
  return directory_exists?("#{DIR_ROOT}mount") && directory_exists?("#{DIR_ROOT}mount/Evidence_files") && directory_exists?("#{DIR_ROOT}mount/Evidence_template")
end

def create_directory_structure
  if directory_exists?("#{DIR_ROOT}mount")
    puts '-- Creating mount directory --'
    FileUtils.mkdir("#{DIR_ROOT}mount")
  else
    puts '-- Mount directory already exists --'
  end

  if directory_exists?("#{DIR_ROOT}mount/Evidence_files")
    puts '-- Creating mount/Evidence_files directory --'
    FileUtils.mkdir("#{DIR_ROOT}mount/Evidence_files")
  else
    puts '-- Mount/Evidence_files directory already exists --'
  end

  if directory_exists?("#{DIR_ROOT}mount/Evidence_template")
    puts '-- Creating mount/Evidence_template directory --'
    FileUtils.mkdir("#{DIR_ROOT}mount/Evidence_template") unless directory_exists?("#{DIR_ROOT}mount/Evidence_template")
  else
    puts '-- Mount/Evidence_template directory already exists --'
  end
end

def move_all_modules
  # puts Dir.glob("#{DIR_ROOT}modules/**/**/Evidence_files/*")
  # puts Dir.glob("#{DIR_ROOT}modules/**/**/Evidence_templates/*")

  FileUtils.cp_r(Dir.glob("#{DIR_ROOT}modules/**/**/Evidence_files/*"),"#{DIR_ROOT}mount/Evidence_files")
  FileUtils.cp_r(Dir.glob("#{DIR_ROOT}modules/**/**/Evidence_template/*"),"#{DIR_ROOT}mount/Evidence_template")

  # Dir.glob("#{ROOT_DIR}/modules/vulnerabilities/*/*/*/*/").each do |puppet_module_directory|
  #   module_path = "#{ROOT_DIR}/mount/puppet/module/"
  #   FileUtils.cp_r(puppet_module_directory, module_path)
  # end
end

# puts check_directory_structure

def create_mount
  if(check_directory_structure == true)
    puts '-- Mount directory structure exists --'
    puts '-- Moving all mount modules --'
    move_all_modules
  else
    puts '-- Creating mount directory structure --'
    create_directory_structure
    puts '-- Moving all mount modules --'
    move_all_modules
  end
end