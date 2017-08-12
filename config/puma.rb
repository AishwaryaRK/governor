min_threads = Governor::Config[:puma, :threads, :min].to_i
max_threads = Governor::Config[:puma, :threads, :max].to_i

server_host = Governor::Config[:puma, :host]
server_port = Governor::Config[:puma, :port].to_i
server_envr = Governor::Config[:rails, :env]

threads(min_threads, max_threads)
port(server_port, server_host)
environment(server_envr)

plugin :tmp_restart
