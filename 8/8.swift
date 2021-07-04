import Foundation

let n = 2
let m = 15
var array = [2, 3]

// 한 번 계산된 결과를 저장하기 위한 DP 테이블 초기화
var d = Array(repeating: 10001, count: m + 1)

// 다이나믹 프로그래밍(Dynamic Programming) 진행(보텀업)
d[0] = 0
for i in 0...n - 1 {
    for j in array[i]...m {
        // (i - k)원을 만드는 방법이 존재하는 경우
        if d[j - array[i]] != 10001 {
            d[j] = min(d[j], d[j - array[i]] + 1)
        }
    }
}

// 계산된 결과 출력
if d[m] == 10001 { // 최종적으로 M원을 만드는 방법이 없는 경우
    print(-1)
} else {
    print(d[m])
}
