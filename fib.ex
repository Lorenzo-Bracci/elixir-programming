defmodule Fib do
  def fb(n,m) do
    spawn(fn() -> fix(n,m) end)
  end
  def fix(0, _) do 0 end
def fix(1, _) do 1 end
def fix(n, m) when n > m do
r1 = :rand.uniform(n)
r2 = :rand.uniform(n)
parallel(fn() -> fix(n-1, m) end, r1)
parallel(fn() -> fix(n-2, m) end, r2)
f1 = collect(r1)
f2 = collect(r2)
f1 + f2
end
def fix(n, _) do fib(n) end
def fib(0) do 0 end
def fib(1) do 1 end
def fib(n) do
r1 = :rand.uniform(n)
r2 = :rand.uniform(n)
parallel(fn() -> fib(n-1) end, r1)
parallel(fn() -> fib(n-2) end, r2)
f1 = collect(r1)
f2 = collect(r2)
f1 + f2
end

def parallel(fun, ref) do
self = self()
spawn(fn() ->
res = fun.()
send(self, {:ok, ref, res})
end)
end
def collect(ref) do
receive do
{:ok, ref, res} ->
res
end
end
end
