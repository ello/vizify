require 'sinatra/base'
require 'digest/md5'
require 'logger'

$stdout.sync = true

class VizifyApp < Sinatra::Base

  enable :logging

  configure :development, :test do
    set :logging, Logger::DEBUG
  end

  configure :production do
    set :logging, Logger.const_get(ENV['LOG_LEVEL'] || 'INFO')
  end

  helpers do
    def render_dot(code)
      logger.debug "Rendering DOT: #{code}"
      digest = Digest::MD5.hexdigest(code)
      file = Tempfile.new([digest, '.svg'])
      begin
        file.close
        IO.popen("dot -Tsvg -o #{file.path}", 'r+', err: [ :child, :out ]) do |pipe|
          pipe.puts(code)
          pipe.close_write
          logger.debug pipe.read
        end
        file.open
        return file.read
      ensure
        file.close
        file.unlink
      end
    end
  end

  get '/dot' do
    code = CGI.unescape(request.query_string).gsub('&', "\n")
    content_type :svg
    render_dot(code)
  end

  get '/url' do
    code = open(params[:url]).read
    content_type :svg
    render_dot(code)
  end
end
