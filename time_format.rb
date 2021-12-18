# frozen_string_literal: true

class TimeFormat
  TIME_KEY = { 'year' => '%Y', 'month' => '%m', 'day' => '%d', 'hour' => '%H',
               'minute' => '%M', 'second' => '%S' }.freeze

  def initialize(params)
    @params = params
    @invalid_params = unknown_format_key
  end

  def result
    Time.now.strftime(time_by_format).to_s
  end

  def invalid_format
    "Unknown time format [#{@invalid_params.join(',')}]\n"
  end

  def success?
    @invalid_params.empty?
  end

  private

  def unknown_format_key
    @params - TIME_KEY.keys
  end

  def time_by_format
    @params.map { |key| TIME_KEY[key] }.join('-')
  end
end
