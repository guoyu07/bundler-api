threads ENV.fetch('MIN_THREADS', 1), ENV.fetch('MAX_THREADS', 1)
port 5000
workers ENV.fetch('WORKER_COUNT', 1)
daemonize false

require 'bundler_api/metriks'
BundlerApi::Metriks.start

require 'puma_worker_killer'
PumaWorkerKiller.enable_rolling_restart

on_worker_boot do |index|
  BundlerApi::Metriks.start(index)
end
