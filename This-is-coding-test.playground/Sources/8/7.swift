import Foundation

let n = 4

// 앞서 계산된 결과를 저장하기 위한 DP 테이블 초기화
var d = Array(repeating: 0, count: 1001)

// 다이나믹 프로그래밍(Dynamic Programming) 진행 (보텀업)
d[1] = 1
d[2] = 3
for i in 3...n {
    d[i] = (d[i - 1] + 2 * d[i - 2]) % 796796
}

// 계산된 결과 출력
print(d[n])
