import Foundation

// 책 풀이
let n = 3
// 연산을 수행하고자 하는 수 리스트
let data = [3, 4, 5]
// 더하기, 빼기, 곱하기, 나누기 연산자 개수
var add = 1
var sub = 0
var mul = 1
var div = 0

// 최솟값과 최댓값 초기화
var M = -1
var m = 1000

// 깊이 우선 탐색 (DFS) 메서드
func dfs(i: Int, now: Int) {
    // 모든 연산자를 다 사용한 경우, 최솟값과 최댓값 업데이트
    if i == n {
        m = min(m, now)
        M = max(M, now)
    } else {
        // 각 연산자에 대하여 재귀적으로 수행
        if add > 0 {
            add -= 1
            dfs(i: i + 1, now: now + data[i])
            add += 1
        }
        if sub > 0 {
            sub -= 1
            dfs(i: i + 1, now: now - data[i])
            sub += 1
        }

        if mul > 0 {
            mul -= 1
            dfs(i: i + 1, now: now * data[i])
            mul += 1
        }

        if div > 0 {
            div -= 1
            dfs(i: i + 1, now: Int(now / data[i])) // 나눌 때는 나머지를 제거
            div += 1
        }

    }

}

// DFS 메서드 호출
dfs(i: 1, now: data[0])

// 최댓값과 최솟값 차례대로 출력
print(M)
print(m)
