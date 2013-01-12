#include "euler.h"

int sum_of_multiples_below(int cutoff) {
  int sum = 0;
  int i;
  for(i=1; i<cutoff; i++) {
    if(i % 3 == 0 || i % 5 == 0) {
      sum += i;
    }
  }
  return sum;
}

int solution() {
  return sum_of_multiples_below(1000);
}