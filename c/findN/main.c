#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int linearSearch(int n, int *arr, int searchValue) {
  for (int i = 0; i < n; i++) {
    if (arr[i] == searchValue) {
      return i;
    }
  }
  // not found
  return -1;
}

int binarySearch(int n, int *arr, int searchValue) {
  int low = 0;
  int high = n - 1;

  while (low <= high) {
    int mid = low + (high - low) / 2;
    if (arr[mid] == searchValue) {
      return mid;
    } else if (arr[mid] < searchValue) {
      low = mid + 1;
    } else {
      high = mid - 1;
    }
  }
  return -1;
}

int perfTest(int n, int (*searchFunc)(int, int *, int), int *arr,
             int searchValue) {
  clock_t start, end;
  double cpu_time_used;

  start = clock();
  searchFunc(n, arr, searchValue);
  end = clock();
  cpu_time_used = ((double)(end - start)) / CLOCKS_PER_SEC;
  printf("Took %f seconds\n", cpu_time_used);

  return 0;
}

int main(void) {
  int n, searchValue;
  do {
    printf("enter n ");
    scanf("%d", &n);
  } while (n < 100 && n < 0);

  int arr[n];
  for (int i = 0; i < n; i++) {
    printf("enter arr[%d] ", i);
    scanf("%d", arr + i);
  }

  printf("enter search value ");
  scanf("%d", &searchValue);

  printf("linear search time: ");
  perfTest(n, linearSearch, arr, searchValue);
  printf("binary search time: ");
  perfTest(n, binarySearch, arr, searchValue);

  return 0;
}
