nil  # => nil
true  # => true
:test  # => :test
1  # => 1
1.2  # => 1.2
"Testing"  # => "Testing"
'Testing'  # => 'Testing'

is_binary("Testing")  # => true
is_binary('Testing')  # => false
is_list('Testing')  # => true
is_list("Testing")  # => false

# Lists
[1, 2, 3]  # => [1, 2, 3]

# Tuples
{:ok, "Test"}  # => {:ok, "Test"}

# Maps
map = %{first_name: "Pawel", last_namne: "Dawczak"}  # => %{first_name: "Pawel", last_namne: "Dawczak"}
map[:first_name]  # => "Pawel"

# Keyword Lists
opts = [per_page: 3, current_page: 1, per_page: 5]  # => [per_page: 3, current_page: 1, per_page: 5]
opts[:per_page]  # => 3
Keyword.get_values(opts, :per_page)  # => [3, 5]

# Structs
defmodule User do
  defstruct [:first_name, :last_name, username: "Guest"]
end
%User{first_name: "Pawel", last_namne: "Dawczak"}
# => %User{first_name: "Pawel", last_name: "Dawczak", username: "Guest"}

# Functions
inc = fn x -> x + 1 end
inc.(3)  # => 4

dec = &(&1 - 1)
dec.(3)  # => 2

defmodule MyModule do
  def square(x) do
    x * 2
  end

  def multi(x, y), do: x * y
end

MyModule.square(4)  # => 8
MyModule.multi(3, 4)  # => 12

# Comprehensions

for x <- (1..5),
  y <- [:blue, :red],
  rem(x, 2) == 0 do
    "#{x*x}-#{y}"
  end  # => ["4-blue", "4-red", "16-blue", "16-red"]

# Lets talk about =

x = 1  # => 1
1 = x  # => 1
2 = x  # => %MatchError{term: 1}

list = [20, 21, 22]
[a, b, c] = list

hd(list)
tl(list)

[head | tail] = list

File.read("./nice_file")  # => {:ok, "Hello World! Nice to see you all!\n"}
File.read!("./non_existing_one")  # => %File.Error{action: "read file", path: "./non_existing_one", reason: :enoent}

div = fn
  _, 0 -> :error
  x, y -> x / y
end

div.(4, 2)
div.(5, 0)

format = fn
  :error ->
    "Oh! Doughnuts!"

  num when num > 2 ->
    "Wow! Result is #{num}"

  num ->
    "Oh well..."
end

format.(div.(10, 2))
format.(div.(5, 0))
format.(div.(4, 2))

String.reverse(String.upcase(format.(div.(10, 2))))

# Pipeline operator
div.(10, 2)
|> format.()
|> String.upcase
|> String.reverse

# 1. Fibonacci!
defmodule Fib do
  def of(0), do: 1
  def of(1), do: 1
  def of(n) when n > 1, do: of(n-1) + of(n-2)
end

Fib.of(5)
Fib.of(-6)

# 2. map
defmodule M do
  def map(list, fun), do: do_map(list, fun, [])

  defp do_map([], fun, acc), do: Enum.reverse(acc)
  defp do_map([head | tail], fun, acc) do
    result = fun.(head)
    do_map(tail, fun, [result | acc])
  end
end

M.map([], fn x -> x * x end) # => []
M.map([1, 2, 3], fn x -> x * x end) # => [1, 4, 9]

# 3. dedup
defmodule D do
  def dedup(list), do: do_dedup(list, [])

  defp do_dedup([], acc), do: Enum.reverse(acc)
  defp do_dedup([num | tail], [{cnt, num} | acc_tail]) do
    do_dedup(tail, [{cnt + 1, num} | acc_tail])
  end
  defp do_dedup([num, num | tail], acc) do
    do_dedup(tail, [{2, num} | acc])
  end
  defp do_dedup([head | tail], acc), do: do_dedup(tail, [head | acc])
end

D.dedup([1, 2, 3, 4]) # => [1, 2, 3, 4]
D.dedup([1, 1, 1, 2, 3, 3]) # => [{3, 1}, 2, {2, 3}]
