require 'prime'

def nth_prime(n)
  Prime.first(n).last
end

def solution
  nth_prime(10_001)
end