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
  case RbConfig::CONFIG['host_os']
  when 'mingw32'
    puts 'on windows; not implemented'
  when 'linux', 'linux-gnu'
    install_linux
  else
    puts 'unrecognised host os :('
  end
end

def install_linux
  replace_all = false
  exclude_files = %w(Rakefile .gitignore config.yml)
  count_identical = 0
  count_total = 0

  Dir['**/*'].each do |file|
    next if exclude_files.include?(file) || File.directory?(file)
    count_total += 1
    
    if File.symlink?(dotfile_path(file)) && !File.exists?(dotfile_path(file))
      puts "fixing broken symlink: #{dotfile_path(file)}"
      File.delete(dotfile_path(file))
      create_symlink(file)
      next
    end

    if File.exists?(dotfile_path(file))
      if File.identical?(file, dotfile_path(file))
        count_identical += 1 
      elsif replace_all
        create_symlink(file)
      else
        print "overwrite #{dotfile_path(file)}? [ynaq] "
        case $stdin.gets.chomp
        when 'a'
          replace_all = true
          create_symlink(file)
        when 'y'
          create_symlink(file) 
        when 'q'
          exit
        else
          puts "skipping #{dotfile_path(file)}"
        end
      end
    else
      puts "adding new file #{dotfile_path(file)}"
      create_symlink(file)
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

def create_symlink(file)
  dest = dotfile_path(file)
  File.delete(dest) if File.exists?(dest)
  FileUtils.mkdir_p(File.dirname(dest)) unless File.directory? File.dirname(dest)
  if File.extname(file) == ".erb"
    File.open(dest, "w") { |f| f.write(ERB.new(File.read(file)).result(BindingHolder.get_binding)) }
  else
    File.symlink(File.expand_path(file), dest)
  end
end

def dotfile_path(file)
  return File.join(ENV['HOME'], ".#{file.sub('.erb', '')}")
end

class BindingHolder
  class << self
    def get_binding
      unless @binding
        config = YAML::load_file('config.yml')
        ns = OpenStruct.new(:config => config)
        @binding = ns.instance_eval { binding }
      end
      @binding
    end
  end
end
