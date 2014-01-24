require_relative 'database'
require_relative 'contact'
require_relative 'application'
require_relative 'app'

set :port, 9393
set :bind, 9393

 
Application.new.run