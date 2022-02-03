import Foundation

let n = 4
let array = [1, 3, 1, 5]

// 앞서 계산된 결과를 저장하기 위한 DP 테이블 초기화
var d = Array(repeating: 0, count: 100)

// 다이나믹 프로그래밍(Dynamic Programming) 진행 (보텀업)
d[0] = array[0]
d[1] = max(array[0], array[1])
for i in 2...n - 1 {
    d[i] = max(d[i - 1], d[i - 2] + array[i])
}

// 계산된 결과 출력
print(d[n - 1])
