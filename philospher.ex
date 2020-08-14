defmodule Philosopher do
  import Chopstick
def sleep(0) do :ok end
def sleep(t) do
  #{_,{a,b,c}} = :calendar.local_time()
  #:random.seed(a,b,c)
:timer.sleep(:random.uniform(t))
end
def start(hunger,left,right,name,ctlr,left1,right1,seed) do
  philosopher = spawn_link(fn -> init(hunger,left,right,name,ctlr,left1,right1,seed) end)
end
def init(hunger,left,right,name,ctlr,left1,right1,seed) do
  :random.seed(seed,seed,seed)
  phil(hunger,left,right,name,ctlr,left1,right1)
end
def phil(0,_,_,name,ctlr,left1,right1) do
  IO.puts("#{name} is done eating")
  send(ctlr,:done)
  end
  def phil(hunger,left,right,name,ctlr,left1,right1) do
  sleep(1000) #time to think
  case get_sticks2(left,right,name,ctlr,left1,right1) do
    :ok -> sleep(1000) #time to eat
    return_sticks(left,right,name,ctlr,left1,right1)
    IO.puts("#{name} finished a meal and gave the chopsticks back and has #{hunger-1} left!")
    phil(hunger-1,left,right,name,ctlr,left1,right1)
    :no -> phil(hunger,left,right,name,ctlr,left1,right1)
  end
  end
    def return_sticks(left,right,name,ctlr,left1,right1) do
      case return(left) do
        :ok -> IO.puts("#{name} gave back chopstick #{left1}!")
          :ok
        _ -> send(ctlr,:abort)
      end
      case return(right) do
        :ok -> IO.puts("#{name} gave back chopstick #{right1}!")
          :ok
        _ -> send(ctlr,:abort)
      end
end
def get_sticks2(left,right,name,ctlr,left1,right1) do
ref1 = better_request(left)
ref2 = better_request(right)
val1 = granted(ref1,2000)
val2 = granted(ref2,2000)
case val1 do
  :ok ->   IO.puts("#{name} has chopstick #{left1}!")
    case val2 do
    :ok ->   IO.puts("#{name} has chopstick #{right1}!")
      :ok
    :no -> case return(left) do
      :ok -> IO.puts("#{name} gave back chopstick #{left1}!")
      :no
      _ -> send(ctlr,:abort)
    end
  end
  :no -> case val2 do
    :ok -> IO.puts("#{name} has chopstick #{right1}!")
      case return(right) do
      :ok -> IO.puts("#{name} gave back chopstick #{right1}!")
      :no
      _ -> send(ctlr,:abort)
    end
    :no -> :no
  end
  _ -> send(ctlr,:abort)
end
end
    def get_sticks(left,right,name,ctlr,left1,right1) do
      case request(left,4000) do
        :ok ->
        IO.puts("#{name} has chopstick #{left1}!")
        sleep(1000)
        case request(right,4000) do
          :ok -> IO.puts("#{name} has chopstick #{right1}!")
          :ok
          :no -> case return(left) do
            :ok -> IO.puts("#{name} gave back chopstick #{left1}!")
            :no
            _ -> send(ctlr,:abort)
          end
          _ -> send(ctlr,:abort)
        end
        :no ->  :no
        _ -> send(ctlr,:abort)
      end
    end
end
