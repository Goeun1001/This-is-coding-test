import Foundation

// 내 풀이
// 다이나믹 프로그래밍을 위한 2차원 DP 테이블 초기화
let N = 5
var dp = [[7], [3, 8], [8, 1, 0], [2, 7, 4, 4], [4, 5, 2, 6, 5]]

// 다이나믹 프로그래밍 진행
for i in 0...N - 1 {
    for j in 0...i {
        // 왼쪽 위에서 오는 경우
        var left = 0
        var right = 0
        // 왼쪽 위에서 오는 경우
        if j != 0 {
            left = dp[i - 1][j - 1]
        }
        // 오른쪽 위에서 오는 경우
        if j != i {
            right = dp[i - 1][j]
        }
        dp[i][j] = dp[i][j] + max(left, right)
    }
}

var result = 0
for i in 0...N - 1 {
    result = max(result, dp[N - 1])
}

print(result)
