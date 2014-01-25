require 'sinatra'
require 'sinatra/activerecord'
require './environments'
require 'sinatra/flash'
require 'sinatra/redirect_with_flash'
require "rubygems"
require 'sinatra/cookies'
require_relative "contact"
require_relative "database"

set :port, 9393
set :bind, 9393

enable :sessions

helpers do
  def title
    # if @title
    #   "#{@title}"
    # else
    #   "Welcome."
    # end
  end
end

helpers do
  include Rack::Utils
  alias_method :h, :escape_html
end


get "/contact/auth" do
  erb :"contact/auth"
end
post "/contact/auth" do
	response.set_cookie("owner_email", :value => params[:owner_email], :path => "/")
	redirect "/"
end


#-------


get "/contact/create" do
  @contact = Contact.new
  erb :"contact/create"
end
post "/contact" do
  @contact = Contact.new(params[:contact])
  @contact.owner_email = cookies[:owner_email]
  if @contact.save
    redirect "/"
  else
    redirect "/"
  end	
end

# ---------

get "/contact/:id" do
  @contact = Contact.find(params[:id])
  erb :"contact/view"
end

get "/" do
  @contact = Contact.order("importance DESC").where(owner_email: cookies[:owner_email])
  erb :"contact/index"
end

# edit post
get "/contact/:id/edit" do
  @contact = Contact.find(params[:id])
  erb :"contact/edit"
end
post "/contact/:id" do
  @contact = Contact.find(params[:id])
  @contact.update(params[:contact])
  redirect "/contact/#{@contact.id}"
end



# delete
get "/contact/:id/delete" do
  @contact = Contact.find(params[:id])
  erb :"contact/delete"
end
post "/contact/:id/delete" do
  @contact = Contact.find(params[:id])
  @contact.delete
  redirect "/"
end



