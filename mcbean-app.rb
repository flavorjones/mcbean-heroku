#! /usr/bin/env ruby

require 'rubygems'
require 'sinatra'
require 'open-uri'
require 'mcbean'

get "/" do
  erb :index
end

post "/fetch" do
  @url = params['url']
  @format = params['format']
  unless McBean.formats.include?(@format)
    @format = "markdown"
  end
  @content = begin
               McBean.document(open(@url).read).send("to_#{@format}")
             rescue
               $!.to_s
             end
  erb :result
end
