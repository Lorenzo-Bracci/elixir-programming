defmodule Sorting do

def insert(element, []) do
[element]
end

def insert(element, [head|tail]) do
case element < head do
  false -> [head|insert(element,tail)]
  true -> [element,head|tail]
end
end

def isort([]) do
  []
end

def isort([head|tail]) do
list =  isort(tail)
  insert(head, list)
end

def isort2(list) do isort2(list, []) end

def isort2([], sofar) do
  sofar
end

def isort2([head|tail],sofar) do
  sofar = insert(head,sofar)
  IO.puts(inspect(sofar))
  isort2(tail,sofar)
end

def msort(list) do
    case list do
      [] -> :no
        [head|[]] -> [head]
        [head|tail] ->
            {list1, list2} = msplit(list, [], [])
            merge(msort(list1), msort(list2))
    end
end

def merge([], list2) do list2 end
def merge(list1, []) do list1 end
def merge([head1|tail1], [head2|tail2]) do
    if head1 <= head2 do
        [head1|merge(tail1, [head2|tail2])]
    else
    [head2|merge([head1|tail1], tail2)]
      end
end

def msplit(list, list1, list2) do
    case list do
        []  -> {list1, list2}
        [head] -> {[head|list1], list2}
        [head1,head2|tail] -> msplit(tail, [head1|list1], [head2|list2])
    end
end

def qsort([p|[]]) do [p] end
def qsort([]) do [] end
def qsort([p | l]) do
  {list1, list2} = qsplit(p, l, [], [])
  small = qsort(list1)
  large = qsort(list2)
append(small, [p | large])
end


def qsplit(_, [], small, large) do {small, large} end
def qsplit(p, [h | t], small, large) do
  if h<=p  do
    qsplit(p, t, [h|small], large)
  else
    qsplit(p, t, small, [h|large])
  end
end

def append(list1, list2) do
  case list1 do
    [] -> list2
    [h | t] -> [h|append(t,list2)]
  end
end

end
