require 'rake'
require 'fileutils'

desc "create symlinks in $HOME for dotfiles"
task :install do
  replace_all = false
  exclude_files = %w(Rakefile)
  # don't symlink these files, copy them
  copy_files = %w(gitconfig)
  count_identical = 0
  count_total = 0

  Dir['**/*'].each do |file|
    next if exclude_files.include?(file) || File.directory?(file)
    count_total += 1

    if File.symlink?(dotfile_path(file)) && !File.exists?(dotfile_path(file))
      puts "fixing broken symlink: #{dotfile_path(file)}"
      File.delete(dotfile_path(file))
      install_dotfile(file)
      next
    end

    if File.exists?(dotfile_path(file))
      if File.identical?(file, dotfile_path(file))
        count_identical += 1 
      elsif replace_all
        install_dotfile(file)
      else
        print "overwrite #{dotfile_path(file)}? [ynaq] "
        case $stdin.gets.chomp
        when 'a'
          replace_all = true
          install_dotfile(file)
        when 'y'
          install_dotfile(file) 
        when 'q'
          exit
        else
          puts "skipping #{dotfile_path(file)}"
        end
      end
    else
      puts "adding new file #{dotfile_path(file)}"
      install_dotfile(file)
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

def install_dotfile(file)
  dest = dotfile_path(file)
  File.delete(dest) if File.exists?(dest)
  FileUtils.mkdir_p(File.dirname(dest)) unless File.directory? File.dirname(dest)
  if copy_files.include?(file)
    FileUtils.copy(file, dest)
  else
    File.symlink(File.expand_path(file), dest)
  end
end

def dotfile_path(file)
  return File.join(ENV['HOME'], ".#{file}")
end
