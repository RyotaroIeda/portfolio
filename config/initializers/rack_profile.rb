if Rails.env == 'development'
  if ENV.has_key?('ENABLE_RACK_PROFILER')
    require 'rack-mini-profiler'
    Rack::MiniProfilerRails.initialize!(Rails.application)
  end
end
