defmodule Chopstick do
  def request(stick, timeout) do
send(stick, {:request, self()})
receive do
:granted -> :ok
after timeout ->
:no
end
end
def better_request(stick) do
  ref = :rand.uniform(60)
send(stick, {:request, ref, self()})
ref
end
def granted(ref,timeout) do
  receive do
  {:granted, ^ref} -> :ok
  after timeout ->
  :no
  end
end

#ref = redrum(cell)
#val = murder(ref)

  def request(stick) do
send(stick, {:request, self()})
receive do
:granted -> :ok
end
end
def return(stick) do
send(stick, {:return, self()})
receive do
:returned -> :ok
end
end
def quit(stick) do
   send(stick, :quit)
end
  def start do
    stick = spawn_link(fn -> available() end)
  end

  defp available() do
  receive do
  {:request, from} -> send(from, :granted)
  gone()
  {:request, ref, from} -> send(from,{:granted, ref})
  gone()
  :quit -> :ok
  end
  end
  defp gone() do
  receive do
  {:return, from} -> send(from, :returned)
     available()
     :quit -> :ok
  end
  end

end
