require 'prime'

def largest_prime_factor(n)
	n.prime_division.map(&:first).max
end

def solution
	largest_prime_factor 600851475143
end