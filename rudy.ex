defmodule Rudy do
  @threads 5
  def start(port) do
    Process.register(spawn(fn -> init(port) end), :rudy)
  end

  def stop() do
    Process.exit(Process.whereis(:rudy), "Time to die!")
  end
  def init(port) do
      opt = [:list, active: false, reuseaddr: true]

      case :gen_tcp.listen(port, opt) do
        {:ok, listen} ->
          init_handlers(listen,@threads)
          #:gen_tcp.close(listen)
          :ok
        {:error, error} ->
          error
      end
    end
def init_handlers(listen,0) do spawn_link(fn() -> handler(listen) end) end
def init_handlers(listen,n) do
  spawn_link(fn() -> handler(listen) end)
  init_handlers(listen,n-1)
end

    def handler(listen) do
      case :gen_tcp.accept(listen) do
        {:ok, client} ->
          request(client)
        {:error, error} ->
          error
      end
      handler(listen)
    end

    def request(client) do
      recv = :gen_tcp.recv(client, 0)
      case recv do
        {:ok, str} ->
          http_request = HTTP.parse_request(str)
          response = reply(http_request)
          :gen_tcp.send(client, response)
        {:error, error} ->
          IO.puts("RUDY ERROR: #{error}")
      end
      :gen_tcp.close(client)
    end

    def reply({{:get, uri, _}, _, _}) do
      HTTP.ok("Hello!")
    end
end
