import Foundation

// 내 풀이
let N = 4
let M = 4
let array = [[1, 3, 1, 5], [2, 2, 4, 1], [5, 0, 2, 3], [0, 6, 1, 2]]
//let N = 3
//let M = 4
//let array = [[1, 3, 3, 2], [2, 1, 4, 1], [0, 6, 4, 7]]

var current = (x: 0, y: 0) // 현재 위치 저장
var result = 0

for i in 0...M - 1 { // M 번동안
    if i == 0 { // 맨 처음에는
        var maxValue = 0
        for j in 0...N - 1 {
            if array[j][i] > maxValue { // 첫번째 행의 가장 큰 수를 현재 위치에
                maxValue = array[j][i]
                current = (x: j, y: i)
            }
        }
        result += maxValue
    } else { // 그 다음부터는
        var maxValue = 0
        let x = current.x
        let y = current.y
        
        // 오른쪽
        if array[x][y + 1] > maxValue {
            maxValue = array[x][y + 1]
            current = (x: x, y: y + 1)
        }
        if x - 1 != -1 { // 위
            if array[x - 1][y + 1] > maxValue {
                maxValue = array[x - 1][y + 1]
                current = (x: x - 1, y: y + 1)
            }
        }
        if x + 1 != N { // 아래
            if array[x + 1][y + 1] > maxValue {
                maxValue = array[x + 1][y + 1]
                current = (x: x + 1, y: y + 1)
            }
        }
        result += maxValue
    }
    print(current)
}

print(result)

// 책 풀이
// 다이나믹 프로그래밍을 위한 2차원 DP 테이블 초기화
let array2 = [1, 3, 1, 5, 2, 2, 4, 1, 5, 0, 2, 3, 0, 6, 1, 2]
var dp = [[Int]]()

var index = 0
for _ in 0...N - 1 {
    dp.append(Array(array2[index...index + M - 1]))
    index += M
}

// 다이나믹 프로그래밍 진행
for j in 1...M - 1 {
    for i in 0...N - 1 {
        // 왼쪽 위에서 오는 경우
        var left_up = 0
        var left_down = 0
        // 왼쪽 위에서 오는 경우
        if i != 0 {
            left_up = dp[i - 1][j - 1]
        }
        // 왼쪽 아래에서 오는 경우
        if i != N - 1 {
            left_down = dp[i + 1][j - 1]
        }
        // 왼쪽에서 오는 경우
        let left = dp[i][j - 1]
        dp[i][j] = dp[i][j] + max(left_up, left_down, left)
    }
}

result = 0
for i in 0...N - 1 {
    result = max(result, dp[i][M - 1])
}

print(result)
