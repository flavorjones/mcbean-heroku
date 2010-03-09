#! /usr/bin/env ruby

require 'rubygems'
require 'sinatra'
require 'open-uri'

get "/:url" do
  open "http://#{params[:url]}"
end
