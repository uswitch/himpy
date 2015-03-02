require 'rubygems'
require 'uswitchci'

def self.directory
  @@directory ||= File.expand_path File.dirname(__FILE__)
end

def self.cmd(com)
  IO.popen(com) { |io| while (line = io.gets) do puts line end }
end

namespace :himpy do
  desc "Deps"
  task :deps do
    cmd "docker build -t uswitch/ghc #{directory}/docker"
  end

  desc "Build himpy"
  task :build => :deps do
    cmd "docker run -v  #{directory}:/build -t uswitch/ghc"
  end

  desc "Package himpy"
  task :package => :build do
    cmd "docker run -v  #{directory}:/data -t aussielunix/fpm-cook:ubuntu_14.04"
  end

  desc "Upload himpy"
  task :upload do
    Uswitchci::Deb::package_dir("#{directory}/pkg")
  end
end



