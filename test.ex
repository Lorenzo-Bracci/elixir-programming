defmodule Test do

  # Compute the double of a number.
  def double(n) do n*2
end
#C=(F−32)/1.8)
def convertToCelsius(n) do (n-32)/1.8
end

def rectangleArea(n,m) do n*m
end

def squareArea(n) do rectangleArea(n,n)
end

def circleArea(n) do :math.pi * n * n
end

end
