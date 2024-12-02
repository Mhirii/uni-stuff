#include <stdio.h>
int main() {
  int T[10];

  int n;
  do {
    printf("enter n");
    scanf("%d", &n);

  } while (n < 10 && n < 1);

  int max = 0;
  for (int i = 0; i < n; i++) {
    printf("enter T[%d]", i + 1);
    scanf("%d", T + i);
  }
  int sum = 0;
  int min = T[0];
  for (int i = 0; i < n; i++) {
    sum += T[i];
    if (T[i] > max) {
      max = T[i];
    }
    if (T[i] < min) {
      min = T[i];
    }
  }
  printf("sum: %d\n", sum);
  printf("min: %d\n", min);
  printf("max: %d\n", max);

  for (int i = 0; i < n; i++) {
    printf("t [%d] = %d\n", i, *(T + i));
  }

  return 0;
}
