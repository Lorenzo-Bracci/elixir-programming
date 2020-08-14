defmodule Env do
import Tree

def new() do
  :nil
end

def add3(id, str, env) do
  insertkey(id, str, env)
end
def lookup2(id, :nil) do
  :nil
end
def lookup2(id, env) do
  lookup(id,env)
end

def remove2([id|rest], env) do
  remove2(rest,delete2(id,env))
end
def remove2([], env) do
env
end
def closure(free,env) do closure(free, env, new()) end
def closure([], env, newenv) do newenv end
def closure([free|rest], env, newenv) do
  search = lookup2(free,env)
  case search do
    :nil -> :error
    value -> closure(rest,env,add3(free,value,newenv))
  end
end
def args([first|rest], [first2|rest2], closure) do
  if Lists.len([first|rest]) == Lists.len([first2|rest2]) do
    args(rest,rest2,add3(first,first2,closure))
  else
    :error
  end
end
def args([],[],closure) do closure end
end
