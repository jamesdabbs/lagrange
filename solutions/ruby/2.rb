FibMemo = { 1 => 1, 2 => 2 }

def fib(n)
  FibMemo[n] ||= fib(n-1) + fib(n-2)
end

def solution
  sum, i, curr = 0, 1, 1
  while curr < 4_000_000
    curr = fib i
    sum += curr if curr.even?
    i   += 1
  end
  sum
end