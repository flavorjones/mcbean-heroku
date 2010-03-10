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
      result[2] = McBean.document(result[2].first).to_markdown
    end
    result
  end
end

use Markdownify

get "/" do
  erb :index
end

post "/fetch" do
  begin
    open(params['url']).read
  rescue
    "Could not fetch the URL '#{params['url']}'"
  end
end
