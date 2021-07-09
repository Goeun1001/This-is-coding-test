import Foundation

// 책 풀이가 무한으로 도네용... ; 나중에 셀프로 구현해봐야 할 듯
let n = 7
let m = 7
var data = [[2, 0, 0, 0, 1, 1, 0], [0, 0, 1, 0, 1, 2, 0],
            [0, 1, 1, 0, 1, 0, 0], [0, 1, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 1, 1], [0, 1, 0, 0, 0, 0, 0],
            [0, 1, 0, 0, 0, 0, 0]]

var temp = Array(repeating: Array(repeating: 0, count: m), count: n) //  벽을 설치한 뒤의 맵 리스트

// 4가지 이동 방향에 대한 리스트
let dx = [-1, 0, 1, 0]
let dy = [0, 1, 0, -1]

var result = 0

// 깊이 우선 탐색(DFS)을 이용해 각 바이러스가 사방으로 퍼지도록 하기
func virus(x: Int, y: Int) {
    for i in 0...3 {
        let nx = x + dx[i]
        let ny = y + dy[i]
        // 상, 하, 좌, 우 중에서 바이러스가 퍼질 수 있는 경우
        if nx >= 0 && nx < n && ny >= 0 && ny < m {
            if temp[nx][ny] == 0 {
                // 해당 위치에 바이러스 배치하고, 다시 재귀적으로 수행
                temp[nx][ny] = 2
                virus(x:nx, y: ny)
            }
        }
    }
}

// 현재 맵에서 안전 영역의 크기 계산하는 메서드
func getScore() -> Int {
    var score = 0
    for i in 0...n - 1 {
        for j in 0...m - 1 {
            if temp[i][j] == 0 {
                score += 1
            }
        }
    }
    return score
}

// 깊이 우선 탐색(DFS)을 이용해 울타리를 설치하면서, 매 번 안전 영역의 크기 계산
func dfs(count: Int) {
    var count = count
    // 울타리가 3개 설치된 경우
    if count == 3 {
        for i in 0...n - 1 {
            for j in 0...m - 1 {
                temp[i][j] = data[i][j]
            }
        }
        // 각 바이러스의 위치에서 전파 진행
        for i in 0...n - 1 {
            for j in 0...m - 1 {
                if temp[i][j] == 2 {
                    virus(x: i, y: j)
                }
            }
        }
        // 안전 영역의 최대값 계산
        result = max(result, getScore())
        return
    }
    // 빈 공간에 울타리를 설치
    for i in 0...n - 1 {
        for j in 0...m - 1 {
            if data[i][j] == 0 {
                data[i][j] = 1
                count += 1
                dfs(count: count)
                data[i][j] = 0
                count -= 1
            }
        }
    }
}

dfs(count: 0)
print(result)
