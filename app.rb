# frozen_string_literal: true

class App
  def call(env)
    request = Rack::Request.new(env)
    time_format = TimeFormat.new(request_params(request))
    if time_format.success?
      build_response(200, time_format.result)
    else
      build_response(400, time_format.invalid_format)
    end
  end

  private

  def build_response(code, message)
    response = Rack::Response.new
    response.status = code
    response.write message
    response.finish
  end

  def request_params(request)
    request.params['format'].split(',')
  end
end
