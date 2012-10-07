# this file is a modified version of the Rakefile in Ryan Bates'
# dotfiles repo:
#   https://github.com/ryanb/dotfiles

require 'rake'
require 'erb'
require 'yaml'
require 'fileutils'
require 'rbconfig'
require 'ostruct'

desc "create symlinks in $HOME for dotfiles"
task :install do
  install_dotfiles
end

task :default => :install

def install_dotfiles
  replace_all = false
  exclude_files = %w(Rakefile .gitignore config.yml)
  count_identical = 0
  count_total = 0

  Dir['**/*'].each do |file|
    next if exclude_files.include?(file) || File.directory?(file)
    count_total += 1
    
    next if fix_symlink_if_broken(file)

    if File.exists?(dotfile_path(file))
      if dotfile_identical? file
        count_identical += 1 
      elsif replace_all
        symlink_dotfile(file)
      else
        print "overwrite #{dotfile_path(file)}? [ynaq] "
        case $stdin.gets.chomp
        when 'a'
          replace_all = true
          symlink_dotfile(file)
        when 'y'
          symlink_dotfile(file) 
        when 'q'
          exit
        else
          puts "skipping #{dotfile_path(file)}"
        end
      end
    else
      puts "adding new file #{dotfile_path(file)}"
      symlink_dotfile(file)
    end
  end

  if count_identical == count_total
    puts "nothing to do"
  elsif count_identical > 0
    puts "#{count_identical} other files were identical"
  else
    puts "done"
  end
end

def symlink_dotfile(file)
  dest = dotfile_path(file)
  File.delete(dest) if File.exists?(dest)
  FileUtils.mkdir_p(File.dirname(dest)) unless File.directory? File.dirname(dest)
  if File.extname(file) == ".erb"
    File.open(dest, "w") { |f| f.write(erbify(file)) }
  else
    make_symlink(File.expand_path(file), dest)
  end
end

def make_symlink(src, dest)
  if RbConfig::CONFIG['host_os'] == 'mingw32'
    FileUtils.copy(src, dest)
  else
    File.symlink(src, dest)
  end
end

def fix_symlink_if_broken(file)
  if File.symlink?(dotfile_path(file)) && !File.exists?(dotfile_path(file))
    puts "fixing broken symlink: #{dotfile_path(file)}"
    File.delete(dotfile_path(file))
    symlink_dotfile(file)
    return true
  end
end

def dotfile_path(file)
  return File.join(ENV['HOME'], ".#{file.sub('.erb', '')}")
end

def dotfile_identical?(file)
  dotfile = dotfile_path(file)
  return true if File.identical?(file, dotfile)

  new_file_contents = File.extname(file) == '.erb' ?
    erbify(file) : File.read(file)
  return new_file_contents == File.read(dotfile)
end

# takes a file, returns erbed string
def erbify(file)
  ERB.new(File.read(file)).result(BindingHolder.get_binding)
end

class BindingHolder
  def self.get_binding
    @binding ||= load_binding
  end

  private
  def self.load_binding
    config = YAML::load_file('config.yml')
    ns = OpenStruct.new(:config => config)
    return ns.instance_eval { binding }
  end
end
