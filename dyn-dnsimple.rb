require 'rubygems'
require 'em-http-request'
require 'sinatra/base'
require 'thin'
require 'logger'
require 'yaml'
require 'dnsimple'

APP_ROOT = File.dirname(__FILE__)

$config = YAML.load_file(File.join(APP_ROOT, 'config', 'config.yml'))
$current_ip = ""

require File.join(APP_ROOT, 'lib', 'dyn-dnsimple.rb')

EventMachine.run do
  # bring in the Sinatra web app
  require File.join(APP_ROOT, 'app', 'app.rb')

  EventMachine.add_periodic_timer($config['update_frequency']) {
    DynDNSimple.refresh
  }
end
