import Foundation

// 앞서 계산된 결과를 저장하기 위한 DP 테이블 초기화
var d = Array(repeating: 0, count: 100)

// 첫 번째 피보나치 수와 두 번째 피보나치 수는 1
d[1] = 1
d[2] = 1
let n = 4

// 피보나치 함수(Fibonacci Function) 반복문으로 구현(보텀업 다이나믹 프로그래밍)
for i in 3...n + 1 {
    d[i] = d[i - 1] + d[i - 2]
}

print(d[n])
