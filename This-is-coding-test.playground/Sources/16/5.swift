import Foundation

// 내 풀이
let N = 15
// 1부터 인덱스 시작
var result = [Int]()
var dp = Array(repeating: 0, count: 10000) // 1 -> 못생긴 숭

dp[1] = 1
dp[2] = 1
dp[3] = 1
dp[5] = 1

// 다이나믹 프로그래밍 진행
for i in 1...10000 {
    if dp[i] == 1 {
        result.append(i)
        continue
    }
    
    if i % 2 == 0 && dp[i / 2] == 1 {
        result.append(i)
        dp[i] = 1
    } else if i % 3 == 0 && dp[i / 3] == 1 {
        result.append(i)
        dp[i] = 1
    } else if i % 5 == 0 && dp[i / 5] == 1 {
        result.append(i)
        dp[i] = 1
    }
    
    if result.count == N {
        break
    }
}

print(result[N - 1])
