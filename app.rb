# frozen_string_literal: true

class App
  def call(env)
    request = Rack::Request.new(env)
    if valid_path?(request) && !request_params(request).empty?
      time_response(request)
    else
      response(404, "Invalid path or empty params\n")
    end
  end

  private

  def time_response(request)
    time_format = Formats.new(request_params(request))
    if time_format.valid?
      response(200, time_format.result)
    else
      response(400, "Unknown time format [#{time_format.call.join(',')}]\n")
    end
  end

  def response(code, message)
    response = Rack::Response.new
    response.status = code
    response['Content-type'] = 'text/plain'
    response.write message
    response.finish
  end

  def request_params(request)
    request.params['format'].split(',')
  end

  def valid_path?(request)
    request.path.match(/time/)
  end
end
