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
    set :logging, Logger::INFO
  end

  helpers do
    def render_dot(code)
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

  get '/' do
    if params['url'] || params['dot']
      code = if params[:url]
              open(params[:url]).read
            elsif params[:dot]
              params[:dot]
            end
      content_type :svg
      render_dot(code)
    else
      status 422
    end
  end
end
