defmodule Tree do
  import Lists
  def member(_, :nil) do :no end
  def member(e, {:leaf, e}) do :yes end
  def member(_, {:leaf, _}) do :no end
  def member(e, {:node, e, _, _}) do :yes end
def member(e, {:node, v, left, _}) when e < v do
       member(e, left)
end
def member(e, {:node, _, _, right})  do
       member(e, right)
end

def insert(e, :nil)  do  {:leaf, e}  end
def insert(e, {:leaf, v}) when e < v  do {:node, v, {:leaf, e}, :nil } end
def insert(e, {:leaf, v}) do  {:node, v, :nil, {:leaf, e} }   end
def insert(e, {:node, v, left, right }) when e < v do
   {:node,v,insert(e,left),right}
end
def insert(e, {:node, v, left, right })  do
   {:node,v,left,insert(e,right)}
end

def rightmost({:leaf, e}) do  e  end
def rightmost({:node, _, _ , right}) when right != :nil do
  rightmost(right)
 end
 def rightmost({:node, e, left , _}) do
    e
  end

  def rightmost({:node, _, _, _ , right}) when right != :nil do
    rightmost(right)
   end
   def rightmost({:node, key,value, left , _}) do
      {key,value}
    end

def delete(e, {:leaf, e}) do  :nil  end
def delete(e, {:node, e, :nil, right}) do  right  end
def delete(e, {:node, e, left, :nil}) do  left  end
def delete(e, {:node, e, left, right})  do
  rightmost = rightmost(left)
  leftsubtree =  delete(rightmost, left)
   {:node, rightmost, leftsubtree, right}
end
def delete(e, {:node, v, left, right}) when e < v do
  newnode =  {:node, v, delete(e,left),  right}
end
def delete(e, {:node, v, left, right})  do
    {:node, v,  left,  delete(e,right)}
end

def lookup(_, :nil) do :nil end
def lookup(key, {:node, key,value, _, _}) do  value end
def lookup(e, {:node, key,value, left, _}) when e < key do
     lookup(e, left)
end
def lookup(e, {:node, _, _, _, right})  do
     lookup(e, right)
end
def delete2(key, :nil) do  :nil  end
def delete2(key, {:node, key,value, :nil, right}) do  right  end
def delete2(key, {:node, key,value, left, :nil}) do  left  end
def delete2(key, {:node, key,value, left, right})  do
  {rightmost,key} = rightmost(left)
  leftsubtree =  delete(rightmost, left)
   {:node, rightmost,key, leftsubtree, right}
end
def delete2(e, {:node, key,value, left, right}) when e < key do
    {:node, key,value, delete2(e,left),  right}
end
def delete2(e, {:node, key,value, left, right})  do
    {:node, key,value,  left,  delete2(e,right)}
end

def insertkey(newkey,newval, :nil)  do  {:node, newkey,newval,:nil,:nil}  end
def insertkey(newkey,newval, {:node, key,val, left, right }) when newkey < key do
   {:node,key,val,insertkey(newkey,newval,left),right}
end
def insertkey(newkey,newval, {:node, key,val, left, right }) when newkey > key do
   {:node,key,val,left,insertkey(newkey,newval,right)}
end
def insertkey(newkey,newval, {:node, newkey,val, left, right })  do
   {:node,newkey,newval,left,right}
end

def inorder(:nil) do [] end
def inorder({:node, key,value, left, right}) do
append(inorder(left),[{key,value}|inorder(right)])
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
def merge([{key1,value1}|tail1], [{key2,value2}|tail2]) do
    if value1 <= value2 do
        [{key1,value1}|merge(tail1, [{key2,value2}|tail2])]
    else
    [{key2,value2}|merge([{key1,value1}|tail1], tail2)]
      end
end
def msplit(list, list1, list2) do
    case list do
        []  -> {list1, list2}
        [head] -> {[head|list1], list2}
        [head1,head2|tail] -> msplit(tail, [head1|list1], [head2|list2])
    end
end

def ordered_by_value({:node, key,value, left, right}) do
  msort(inorder({:node, key,value, left, right}))
end

end
