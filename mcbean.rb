#! /usr/bin/env ruby

require 'rubygems'
require 'sinatra'
require 'open-uri'
require 'mcbean'

class Markdownify
  def initialize(app, options={})
    @app = app
  end

  def call(env)
    result = @app.call(env)
    if env["REQUEST_URI"] == "/fetch"
      result[1] = {"Content-Type" => "text/plain"}
      result[2] = McBean.document(result[2]).to_markdown
    end
    result
  end
end

use Markdownify

get "/" do
  erb :index
end

post "/fetch" do
  open params['url']
end
