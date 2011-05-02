class App < Sinatra::Base
  require 'haml'
  set :haml, :format => :html5
  set :static, true

  set :root, File.join(File.dirname(__FILE__), "..") 
  set :views, Proc.new { File.join(root, "app", "views") }
  set :public, Proc.new { File.join(root, "public") }

  get '/' do
    haml :index
  end
  
  get '/refresh' do
    DynDNSimple.refresh
    redirect '/'
  end
end

App.run!({:port => $config['http_port']})