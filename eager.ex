defmodule Eager do
  import Env
  def eval_expr([first|rest],env) do
    eval_expr([first|rest],[],env)
  end
  def eval_expr([first|rest],acc,env) do
    case eval_expr(first,env) do
      :error ->  :error
      {:ok,{hp, tp}} ->  eval_expr(rest,[{hp,tp}|acc],env)
      {:ok, str} ->  eval_expr(rest,[str|acc],env)
    end
  end
def eval_expr([], acc, env) do
  Lists.reverse(acc)
 end
  def eval_expr({:atm, id}, _) do {:ok, id} end
def eval_expr({:var, id}, env) do
case lookup2(id,env) do
nil -> :error
str -> {:ok, str}
end
end
def eval_expr({:cons, head, tail}, env) do
case eval_expr(head, env) do
:error -> :error
{:ok, value} ->
case eval_expr(tail, env) do
:error -> :error
{:ok, ts} -> {:ok, {value, ts}}
end
end
end

def eval_match(:ignore, x, env) do
{:ok, env}
end
def eval_match({:atm, id}, id, env) do
{:ok, env}
end
def eval_match({:var, id}, str, env) do
case eval_expr({:var, id},env) do
:error ->
{:ok, add3(id,str,env)}
{_, ^str} -> #the power sign is used to keep the old value of str and not reset its value as we usually do in pattern matching
{:ok, env}
{_, _} ->
:error
end
end
#def eval_match({:cons, hp, tp}, {:cons, hp2, tp2}, env) do
#  {_,val1} = eval_expr(hp2,env)
#  {_,val2} = eval_expr(tp2,env)
#case eval_match(hp, val1, env) do
#:error -> :error
#{:ok, env2} ->
#  eval_match(tp, val2, env2)
#end
#end
def eval_match({:cons, hp, tp}, {val1, val2}, env) do
case eval_match(hp, val1, env) do
:error -> :error
{:ok, env2} ->
  eval_match(tp, val2, env2)
end
end
def eval_match(_, _, _) do
:error
end

def extract_vars(pattern) do
case pattern do
   {:var, id} -> [id]
   :ignore -> []
   {:atm, atm} -> []
   {:cons, hp, tp} -> extract_vars(hp) ++ extract_vars(tp)
end
end
def eval_scope(pattern, env) do
Env.remove2(extract_vars(pattern), env)
end
def eval_seq([exp], env) do
eval_expr(exp, env)
end
def eval_seq([{:match, pattern, expr} | rest], env) do
case eval_expr(expr, env) do
:error -> :error
 {_, expression} -> #check this out
env2 = eval_scope(pattern, env)
case eval_match(pattern, expression, env2) do
:error ->
:error
{:ok, env3} ->
#  inorder(env3)
#  IO.puts("done")
eval_seq(rest, env3)
end
end
end
def seq() do
  [{:match, {:var, :x}, {:atm, :a}},
  {:match, {:var, :f},
  {:lambda, [:y], [:x], [{:cons, {:var, :x}, {:var, :y}}]}},
  {:apply, {:var, :f}, [{:atm, :b}]}
  ]

end
def inorder(:nil) do :nil end
def inorder({:node, key,value, left, right}) do
inorder(left)
IO.puts(key)
case value do
{a, b} -> IO.puts(a)
IO.puts(b)
  value -> IO.puts(value)
end
inorder(right)
end

def eval_expr({:case, expr, cls}, env) do
case eval_expr(expr, env) do
:error -> :error
{_, expression} ->
eval_cls(cls, expression, env)
end
end
def eval_cls([], _, _) do
:error
end
def eval_cls([{:clause, ptr, seq} | cls], expression, env) do
env2 = eval_scope(ptr,env)
case eval_match(ptr,expression,env2) do
:error ->
  eval_cls(cls, expression, env)
  {:ok, envnew} ->
  eval_seq(seq, envnew)
  end
  end

  def eval_expr({:lambda, par, free, seq}, env) do
  case closure(free, env) do
  :error -> :error
  closure -> {:ok, {:closure, par, seq, closure}}
  end
  end
  #{:apply, {:var, :f}, [{:atm, :b}]}
  def eval_expr({:apply, {:var, expr}, args}, env) do
#case eval_expr(lookup2(expr,env),env) do
case lookup2(expr,env) do
:error -> :error
 {:closure, par, seq, closure} ->
case eval_expr(args,env) do
:error ->
:foo
strs ->
env = args(par, strs, closure)
case env do
  :error -> :error
_ -> eval_seq(seq, env)
end
end
end
end

end
