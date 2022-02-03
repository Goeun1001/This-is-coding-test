import Foundation

let n = 3
let m = 3
var graph = [[0, 0, 1], [0, 1, 0], [1, 0, 1]]


// DFS로 특정한 노드를 방문한 뒤에 연결된 모든 노드들도 방문
@discardableResult
func dfs(x: Int, y: Int) -> Bool {
    // 주어진 범위를 벗어나는 경우에는 즉시 종료
    if x <= -1 || x >= n || y <= -1 || y >= m {
        return false
    }
    // 현재 노드를 아직 방문하지 않았다면
    if graph[x][y] == 0 {
        // 해당 노드 방문 처리
        graph[x][y] = 1
        // 상, 하, 좌, 우의 위치들도 모두 재귀적으로 호출
        dfs(x: x - 1, y: y)
        dfs(x: x, y: y - 1)
        dfs(x: x + 1, y: y)
        dfs(x: x, y: y + 1)
        return true
    }
    return false
}

// 모든 노드(위치)에 대하여 음료수 채우기
var result = 0
for i in 0...n - 1 {
    for j in 0...m - 1 {
        // 현재 위치에서 DFS 수행
        if dfs(x: i, y: j) == true {
            result += 1
        }
    }
}

print(result) // 정답 출력
