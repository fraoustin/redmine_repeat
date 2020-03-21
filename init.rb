# encoding: utf-8


require 'redmine'
begin
  require 'config/initializers/session_store.rb'
  rescue LoadError
end

def init_repeat
  Dir::foreach(File.join(File.dirname(__FILE__), 'lib')) do |file|
    next unless /\.rb$/ =~ file
    require_dependency file
  end
end

if Rails::VERSION::MAJOR >= 5
  ActiveSupport::Reloader.to_prepare do
    init_repeat
  end
elsif Rails::VERSION::MAJOR >= 3
  ActionDispatch::Callbacks.to_prepare do
    init_repeat
  end
else
  Dispatcher.to_prepare :redmine_repeat do
    init_repeat
  end
end

Redmine::Plugin.register :redmine_repeat do
  name 'Redmine Repeat'
  author 'Frederic Aoustin'
  description 'The redmine_repeat repeat issue after closure.'
  version '0.1.1'
  url 'https://github.com/fraoustin/redmine_repeat'
  author_url 'https://github.com/fraoustin'
  requires_redmine :version_or_higher => '2.3.0'
end
