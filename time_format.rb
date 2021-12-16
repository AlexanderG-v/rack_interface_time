# frozen_string_literal: true

class TimeFormat
  TIME_KEY = { 'year' => '%Y', 'month' => '%m', 'day' => '%d', 'hour' => '%H',
               'minute' => '%M', 'second' => '%S' }.freeze

  def initialize(params)
    @params = params
    @invalid_params = unknown_format_key
  end

  def result
    "#{Time.now.strftime(time_by_format)}"
  end

  def valid?
    @invalid_params.empty?
  end

  def call
    @invalid_params
  end

  private

  def unknown_format_key
    @params - TIME_KEY.keys
  end

  def time_by_format
    @params.map { |key| TIME_KEY[key]  }.join('-')
  end
end
