Sentry.init do |config|
  config.dsn = Rails.configuration.x.sentry.dsn
  config.breadcrumbs_logger = [:active_support_logger]
  config.send_default_pii = true
  config.enabled_environments = %w[production]
  config.release = Rails.configuration.x.git.commit_sha
end
