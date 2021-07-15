import Foundation

// 내 풀이
var A = Array("cat")
let B = Array("cut") // 1
//var A = Array("sunday")
//let B = Array("saturday") // 3
//var A = Array("saturdayy")
//let B = Array("saturday") // 3

var result = 0

while A != B {
    var diff = B.count - A.count

    if diff > 0 { // insert
        inner: for i in 0...B.count - 1 {
            if A[i] != B[i] {
                A.insert(B[i], at: i)
                result += 1
                diff -= 1
            }
            if diff == 0 { break inner }

        }
    } else if diff < 0 { // remove
        inner: for i in 0...A.count - 1 {
            if i >= B.count || A[i] != B[i] {
                A.remove(at: i)
                result += 1
                diff -= 1
            }
            if diff == 0 { break inner }
        }
    }

    // replace
    for i in 0...B.count - 1 {
        if A[i] != B[i] {
            A[i] = B[i]
            result += 1
        }
    }
}

print(result)

// 책 풀이
// 최소 편집 거리(Edit Distance) 계산을 위한 다이나믹 프로그래밍
func edit(_ str1: String, _ str2: String) -> Int {
    var str1 = Array(str1)
    var str2 = Array(str2)
    let n = str1.count
    let m = str2.count

    // 다이나믹 프로그래밍을 위한 2차원 DP 테이블 초기화
    var dp = Array(repeating: Array(repeating: 0, count: m + 1), count: n + 1)

    // DP 테이블 초기 설정
    for i in 1...n {
        dp[i][0] = i
    }
    for j in 1...m {
        dp[0][j] = j
    }

    // 최소 편집 거리 계산
    for i in 1...n {
        for j in 1...m {
            // 문자가 같다면, 왼쪽 위에 해당하는 수를 그대로 대입
            if str1[i - 1] == str2[j - 1] {
                dp[i][j] = dp[i - 1][j - 1]
            } else {
                // 문자가 다르다면, 세 가지 경우 중에서 최솟값 찾기
                //  삽입(왼쪽), 삭제(위쪽), 교체(왼쪽 위) 중에서 최소 비용을 찾아 대입
                dp[i][j] = 1 + min(dp[i][j - 1], dp[i - 1][j], dp[i - 1][j - 1])
            }
        }
    }
    return dp[n][m]
}

let str1 = "cat"
let str2 = "cut" // 1

// 최소 편집 거리 출력
print(edit(str1, str2))
