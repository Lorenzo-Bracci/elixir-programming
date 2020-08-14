defmodule Recursion do

  @doc """
  Compute the product between of n and m.

  product of n and m :
    if n is 0
      then ...
    otherwise
      the result ...
  """
def posProd(m,n) do
  case m do
    0 -> 0
    m -> n + prod(m-1,n)
  end
end

def negProd(m,n) do
  case m do
0 -> 0
m -> prod(m+1,n) - n
  end
end

  def prod(m,n) do
    case (m<=0) do
      true -> negProd(m,n)
      false -> posProd(m,n)
    end
  end
def power(m,n) do
  case n do
    0 -> 1
    n -> prod(m,power(m,n-1))
  end
end
def qpower(m,n) do
  case n do
    1 -> m
    n -> prod(prod(m,rem(n,2)),qpower(prod(m,m),div(n,2)))
  end
end
def fib(n) do
  case n do
    0 -> 0
    1 -> 1
    _ -> fib(n-1) + fib(n-2)
  end
end
def bench_fib() do
  ls = [8,10,12,14,16,18,20,22,24,26,28,30,32,34,36]
  n = 10

  bench = fn(l) ->
    t = time(n, fn() -> fib(l) end)
    :io.format("n: ~4w  fib(n) calculated in: ~8w us~n", [l, t])
  end

  Enum.each(ls, bench)
end

def time(n, call) do
   {t, _} = :timer.tc(fn -> loop(n, call) end)
   trunc(t/n)
end

def loop(0, _ ) do :ok end
def loop(n, call) do
   call.()
   loop(n-1, call)
end

end
