#include "euler.h"

int fib(int n) {
  if(n<3) return n;
  return fib(n-1) + fib(n-2);
}

int solution() {
  int sum = 0;
  int i, curr;
  for(i=1, curr=1; curr < 4000000; i++, curr=fib(i)) {
    if(curr % 2 == 0) {
      sum += curr;
    }
  }
  return sum;
}