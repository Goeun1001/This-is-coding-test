import Foundation

// 책 풀이
// LIS 사용
let N = Int(readLine()!)!
let soldiers = readLine()!.split(separator: " ").map { Int(String($0))! }
// 다이나믹 프로그래밍을 위한 1차원 DP 테이블 초기화
var dp = Array(repeating: 1, count: N)

// 가장 긴 증가하는 부분 수열(LIS) 알고리즘 수행
for i in 1..<N {
    for j in 0..<i {
        if soldiers[j] > soldiers[i] {
            dp[i] = max(dp[i], dp[j] + 1)
        }
    }
}
// 열외해야 하는 병사의 최소 수를 출력
print(N - dp.max()!)
