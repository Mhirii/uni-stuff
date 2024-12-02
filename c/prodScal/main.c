#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

int *readArr(int n, const char *arrName) {
  int *arr = (int *)malloc(n * sizeof(int));
  for (int i = 0; i < n; i++) {
    printf("%s[%d] = ", arrName, i);
    scanf("%d", arr + i);
  }
  return arr;
}

int scalar(int n) {
  int scalar = 0;
  char formula[1000] = "";

  int *u = readArr(n, "u");
  int *v = readArr(n, "v");

  for (int i = 0; i < n; i++) {
    if (i == 0) {
      sprintf(formula, "%d * %d", u[i], v[i]);
    } else {
      char tmp[50];
      sprintf(tmp, " + %d * %d", u[i], v[i]);
      strcat(formula, tmp);
    }
  }
  printf("Formula: %s\n", formula);

  for (int i = 0; i < n; i++) {
    scalar += u[i] * v[i];
  }
  printf("produit scalaire: %d\n", scalar);

  return 0;
}

int perfTest(int n) {
  clock_t start, end;
  double cpu_time_used;

  start = clock();
  scalar(n);
  end = clock();
  cpu_time_used = ((double)(end - start)) / CLOCKS_PER_SEC;
  printf("Took %f seconds\n", cpu_time_used);

  return 0;
}

int main() {
  int n;
  do {
    printf("enter n ");
    scanf("%d", &n);
  } while (n >= 100 || n <= 0);

  perfTest(n);
  return 0;
}
