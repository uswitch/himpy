class Himpy < FPM::Cookery::Recipe
  homepage 'http://github.com/uswitch/himpy/'
    name     'himpy'
    version  '1.0'
    source   "git@github.com:uswitch/himpy.git", with: 'noop'
    revision  `git rev-list HEAD --count`.chomp 
    maintainer 'Pierre-Yves Ritschard'
    description 'A multithreaded SNMP sender to Riemann'
    post_install 'debian/himpy.postinst'
    config_files '/etc/himpy.conf', '/etc/logrotate.d/himpy'

  def build
  end

  def install
    safesystem "mkdir -p #{destdir('/etc/default')}"
    safesystem "mkdir -p #{destdir('/etc/logrotate.d')}"
    safesystem "mkdir -p #{destdir('/var/log')}"
    safesystem "touch #{destdir('/var/log/himpy.log')}"
    safesystem "mkdir -p #{destdir('/etc/init')}"
    safesystem "cp #{workdir('/debian/himpy.init')} -f #{destdir('/etc/init/himpy.conf')}"
    safesystem "cp #{workdir('himpy.conf.json')} -f #{destdir('/etc/himpy.conf')}"
    safesystem "cp #{workdir('/debian/himpy.logrotate')} -f #{destdir('/etc/logrotate.d/himpy')}"
    safesystem "mkdir -p #{destdir('/usr/local/bin')}"
    safesystem "cp #{workdir('dist/build/himpy/himpy')} -f #{destdir('/usr/local/bin/himpy')}"
  end
end
