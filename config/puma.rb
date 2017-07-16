min_threads = ENV.fetch('GOVERNOR_PUMA_MIN_THREADS') {5}
max_threads = ENV.fetch('GOVERNOR_PUMA_MAX_THREADS') {5}

server_host = ENV.fetch('GOVERNOR_PUMA_HOST') {'127.0.0.1'}
server_port = ENV.fetch('GOVERNOR_PUMA_PORT') {4001}
server_envr = ENV.fetch('RAILS_ENV') {'development'}

threads(min_threads, max_threads)
port(server_port, server_host)
environment(server_envr)
plugin :tmp_restart
