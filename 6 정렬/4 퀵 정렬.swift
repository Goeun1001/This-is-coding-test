import Foundation

var array = [5, 7, 9, 0, 3, 1, 6, 2, 4, 8]

func quickSort(array: inout [Int], start: Int, end: Int) {
    if start >= end {
        return
    }
    let pivot = start
    var left = start + 1
    var right = end
    while (left <= right) {
        // 피벗보다 큰 데이터를 찾을 때까지 반복
        while (left <= end && array[left] <= array[pivot]) {
            left += 1
        }
        // 피벗보다 작은 데이터를 찾을 때까지 반복
        while (right > start && array[right] >= array[pivot]) {
            right -= 1
        }
        if (left > right) { // 엇갈렸다면 작은 데이터와 피벗을 교체
            array.swapAt(right, pivot)
        } else { // 엇갈리지 않았다면 작은 데이터와 큰 데이터를 교체
            array.swapAt(left, right)
        }
    }
    // 분할 이후 왼쪽 부분과 오른쪽 부분에서 각각 정렬 수행
    quickSort(array: &array, start: start, end: right - 1)
    quickSort(array: &array, start: right + 1, end: end)
}

quickSort(array: &array, start: 0, end: array.count - 1)
print(array)
