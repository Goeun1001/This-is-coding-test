import Foundation

let n = 5
let m = 6
var graph = [[1, 0, 1, 0, 1, 0], [1, 1, 1, 1, 1, 1], [0, 0, 0, 0, 0, 1], [1, 1, 1, 1, 1, 1], [1, 1, 1, 1, 1, 1]]
//let n = 3
//let m = 3
//var graph = [[1, 1, 0], [0, 1, 0], [0, 1, 1]]

// 이동할 네 가지 방향 정의 (상, 하, 좌, 우)
let dx = [-1, 1, 0, 0]
let dy = [0, 0, -1, 1]

// BFS 소스코드 구현
func bfs(x: Int, y: Int) -> Int {
    var queue = [Int]()
    queue.append(x)
    queue.append(y)
    
    // 큐가 빌 때까지 반복하기
    while !queue.isEmpty {
        let x = queue.removeFirst()
        let y = queue.removeFirst()
        
        // 현재 위치에서 4가지 방향으로의 위치 확인
        for i in 0...3 {
           let  nx = x + dx[i]
            let ny = y + dy[i]
            // 미로 찾기 공간을 벗어난 경우 무시
            if nx < 0 || nx >= n || ny < 0 || ny >= m {
                continue
            }
            // 벽인 경우 무시
            if graph[nx][ny] == 0 {
                continue
            }
            // 해당 노드를 처음 방문하는 경우에만 최단 거리 기록
            if graph[nx][ny] == 1 {
                graph[nx][ny] = graph[x][y] + 1
                queue.append(nx)
                queue.append(ny)
            }
        }
    }
    // 가장 오른쪽 아래까지의 최단 거리 반환
    return graph[n - 1][m - 1]
}

// BFS를 수행한 결과 출력
print(bfs(x: 0, y: 0))
