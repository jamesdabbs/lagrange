require 'prime'

def sum_of_squares(n)
  (1..n).map { |i| i**2 }.sum
end

def square_of_sum(n)
  (1..n).sum ** 2
end

def solution
  square_of_sum(100) - sum_of_squares(100)
end