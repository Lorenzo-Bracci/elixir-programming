defmodule Huffman do
import Tree
import Lists
  def sample do
    'the quick brown fox jumps over the lazy dog
    this is a sample text that we will use when we build
    up a table we will only handle lower case letters and
    no punctuation symbols the frequency will of course not
    represent english but it is probably not that far off'
  end

  def text()  do
    'this is something that we should encode'
  end

  def test(sample) do
    sample = sample()
    tree = tree(sample)
    encode = encode_table(tree)
    text = text()
    seq = encode(text, encode)
    decode(seq,tree,tree,[])
  end

  def freq(sample) do
    freq(sample, :nil)
  end

  def freq([], freq) do
    ordered_by_value(freq)
  end

  def freq([char | rest], freq) do
    freq(rest, Tree.insertkey(char,Tree.lookup(char,freq)+1,freq))#insert the carachter and compute its value using the lookup function
  end

  def tree(sample) do
    freq = freq(sample)
    huffman(freq)
  end
  def insertnew(element, []) do
  [element]
  end
  def insertnew({char1,freq1}, [{char2,freq2}|tail]) do
  case freq1 < freq2 do
    false -> [{char2,freq2}|insertnew({char1,freq1},tail)]
    true -> [{char1,freq1},{char2,freq2}|tail]
  end
  end
def huffman([{tree,freq}|[]]) do tree end
def huffman([head1,head2|rest]) do
  newNode = build(head1,head2)
  huffman(insertnew(newNode,rest))
end
def build({char1,freq1},{char2,freq2}) do
{{char1, char2}, freq1 + freq2}
end
def traverse({left,right},binary) do
  append(traverse(left,[0|binary]),traverse(right,[1|binary]))
end
def traverse(leaf,binary) do
  [{leaf,Lists.reverse(binary)}]
end
  def encode_table(tree) do
    traverse(tree,[])
  end
  def tree_table([{leaf,list}|rest],tree) do
    tree = insertkey(leaf,list,tree)
    tree_table(rest,tree)
  end
def tree_table([],tree) do
  tree
end
  def decode_table(tree) do
    # To implement...
  end
  def encode(text, table) do #this is gonna return the encoded text in reversed order
    encode(text,tree_table(table,:nil),[])
  end
def encode([char|rest],table,encoding) do
  #encoding = [lookup(char,table)|encoding] #we have a list of lists, this can be fixed by using the append operator
  encoding = append(reverse(lookup(char,table)),encoding)
  encode(rest,table,encoding)
end
def encode([],table,encoding) do
  reverse(encoding)
end

def decode([binary|rest],{left, right},topoftree,solution) do
  case binary == 0 do
    true -> decode(rest,left,topoftree,solution)
    false -> decode(rest,right,topoftree,solution)
  end
end
def decode([],{left, right},topoftree, solution) do
  reverse(solution)
end
def decode(rest,leaf,topoftree, solution) do
  solution = [leaf|solution]
  decode(rest,topoftree,topoftree,solution)
end
end
