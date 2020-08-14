defmodule Lists do

def tak([]) do
  :error
end

def tak([head|tail]) do
  head
end

def drp([]) do
  :no
end

def drp([head|tail]) do
  [:ok|tail]
end

def len([]) do
  0
end

def len([head|tail]) do
  len(tail) + 1
end

def sum([]) do
  0
end

def sum([head|tail]) do
  sum(tail) + head
end

def dupl([head|[]]) do
  [head,head]
end

def dupl([head|tail]) do
  [head,head|dupl(tail)]
end

def add(x,[]) do
  [x]
end

def add(x,[head|tail]) do
  case head == x do
    false -> [head|add(x,tail)]
true -> [head|tail]
end
end

def remove(x,[]) do
  []
end

def remove(x,[head|tail])do
  case head == x do
    false -> [head|remove(x,tail)]
    true -> remove(x,tail)
  end
end

def unique([]) do
  []
end

def unique([head|tail]) do
  [head|unique(remove(head,tail))]
end

def append([],list) do
  list
end

def append([head|tail] , list) do
  [head | append(tail,list)]
end

def nreverse([]) do [] end

def nreverse([h | t]) do
  r = nreverse(t)
  append(r, [h])
end

def reverse(l) do
  reverse(l, [])
end

def reverse([], r) do r end

def reverse([h | t], r) do
  reverse(t, [h | r])
end

end
