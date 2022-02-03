import Foundation

// 1부터 인덱스 시작
let N = Int(readLine()!)!
var time = [0]
var dp = [0]
for _ in 0...N - 1 {
    let td = readLine()!
    let array = td.components(separatedBy: " ")
    time.append(Int(array.first!)!)
    dp.append(Int(array.last!)!)
}
var array = dp

// 다이나믹 프로그래밍 진행
for i in 1...N { // i번째 dp 수정
    if i + time[i] > N + 1 { // N + 1 날까지만 일함
        dp[i] = 0
        array[i] = 0
    }
    for j in 1...i {
        var j = j
        while j < i {
            if i - time[j] >= j {
                dp[i] = max(dp[i], array[i] + dp[j])
            }
            j += time[j]
        }
    }

}

var result = 0
for i in 1...N {
    result = max(result, dp[i])
}

print(result)
