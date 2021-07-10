import Foundation

// 이진 탐색 소스코드 구현 (재귀 함수)
func binarySearch(array: inout [Int], target: Int, start: Int, end: Int) -> Int? {
    if start > end {
        return nil
    }
    let mid = (start + end) / 2
    if array[mid] == target {
        return mid
    } else if array[mid] > target {
        // 중간점의 값보다 찾고자 하는 값이 작은 경우 왼쪽 확인
        return binarySearch(array: &array, target: target, start: start, end: mid - 1)
    } else {
        // 중간점의 값보다 찾고자 하는 값이 큰 경우 오른쪽 확인
        return binarySearch(array: &array, target: target, start: mid + 1, end: end)
    }
}

let n = 10
let target = 7
var array = [1, 3, 5, 7, 9, 11, 13, 15, 17, 19]

let result = binarySearch(array: &array, target: target, start: 0, end: n - 1)

// 이진 탐색 수행 결과 출력
if (result != nil) {
    print(result! + 1)
} else {
    print("원소가 존재하지 않습니다.")
}
