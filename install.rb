#!/usr/bin/env ruby
# this file is a modified version of the Rakefile in Ryan Bates'
# dotfiles repo:
#   https://github.com/ryanb/dotfiles

require 'erb'
require 'fileutils'
require 'rbconfig'

def install_dotfiles
  initialize_uninitialized_submodules
  load_configuration
  copy_dotfiles
end

def initialize_uninitialized_submodules
  `git submodule status`.split("\n").each do |line|
    # if the first char is '-', the submodule needs to be initialized
    if line[0] == '-'
      puts "initializing submodules..."
      system "git submodule update --init"
      return
    end
  end
end

def load_configuration
  create_config unless File.exists?('config.rb')
  require './config'
  if !defined?(DotfilesConfig)
    $stderr.puts "config.rb should define DotfilesConfig"
    $stderr.puts "try deleting it, and redo `./install.rb` to create it automatically"
    exit 1
  end
end

def copy_dotfiles
  replace_all = false
  count_identical = 0
  count_total = 0

  Dir['**/*'].each do |file|
    next if file_excluded?(file) || File.directory?(file)
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

def file_excluded?(file)
  # ignore these specific files
  return true if %w(install.rb .gitignore .gitmodules config.rb).include?(file)
  # ignore everything in '_extras/'
  return true if file.include?('_extras/')
  false
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
  ERB.new(File.read(file)).result(binding)
end

# walks you through creating your config.rb
def create_config
  keys = get_config_keys
  config = {}

  puts "no config.rb found -- creating..."
  keys.each do |key|
    puts "what's your #{key.gsub('_', ' ')}?"
    val = $stdin.gets.chomp
    config[key] = val
  end

  File.open('config.rb', 'w') { |f| f.puts "DotfilesConfig=#{pp_hash(config)}" }
end

def get_config_keys
  keys = []
  Dir.glob('**/*.erb').each do |f|
    keys += File.read(f).scan(/\<%= DotfilesConfig\['(.*?)'\] %\>/).map(&:first)
  end
  keys
end

# pretty-prints a hash, assuming no nesting
def pp_hash(hash)
  str = "{\n  "
  str << hash.map { |k, v| "'#{k}' => '#{v}'" }.join(",\n  ")
  str << "\n}\n"
end

def ensure_in_root!
  dot_root = File.expand_path(File.dirname(__FILE__))
  if Dir.getwd != dot_root
    puts "(in #{dot_root})"
    Dir.chdir(dot_root)
  end
end

if __FILE__ == $0
  ensure_in_root!
  install_dotfiles
end
