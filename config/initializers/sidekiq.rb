Sidekiq.configure_server do |config|
  config.options[:concurrency] = 2
  config.redis = { url: "redis://redis:6379/1" }
end

Sidekiq.configure_client do |config|
  config.redis = { url: "redis://redis:6379/1" }
end
