import Foundation

let n = 4
let m = 6
let array = [19, 15, 10, 17]

// 이진 탐색을 위한 시작점과 끝점 설정
var start = 0 // 0부터 시작해서 높이의 최댓값을 구할 수 있음.
var end = array.max()!

// 이진 탐색 수행 (반복적)
var result = 0
while(start <= end) {
    var total = 0
    let mid = (start + end) / 2
    for x in array {
        // 잘랐을 때의 떡볶이 양 계산
        if x > mid {
            total += x - mid
        }
    }
    // 떡볶이 양이 부족한 경우 더 많이 자르기 (오른쪽 부분 탐색)
    if total < m {
        end = mid - 1
    }
    // 떡볶이 양이 충분한 경우 덜 자르기 (왼쪽 부분 탐색)
    else {
        result = mid // 최대한 덜 잘랐을 때가 정답이므로, 여기에서 result에 기록
        start = mid + 1 // 무조건 최댓값을 구하도록 함.
    }
}


// 정답 출력
print(result)
