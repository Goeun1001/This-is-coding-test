import Foundation

let n = 5
let m = 6
var graph = [[1, 0, 1, 0, 1, 0], [1, 1, 1, 1, 1, 1], [0, 0, 0, 0, 0, 1], [1, 1, 1, 1, 1, 1], [1, 1, 1, 1, 1, 1]]

// 이동할 네 가지 방향 정의 (상, 하, 좌, 우)
let dx = [-1, 1, 0, 0]
let dy = [0, 0, -1, 1]

// BFS 소스코드 구현
func bfs(x: Int, y: Int) -> Int {
    var queue = [(x, y)]
    
    while !queue.isEmpty {
        let arr = queue.removeFirst()
        let x = arr.0
        let y = arr.1
        
        for i in 0...3 {
            let nx = x + dx[i]
            let ny = y + dy[i]
            
            if nx < 0 || nx >= n || ny < 0 || ny >= m { continue }
            if graph[nx][ny] == 0 { continue }
            
            //  해당 노드를 처음 방문하는 경우에만 최단 거리 기록
            if graph[nx][ny] == 1 {
                graph[nx][ny] = graph[x][y] + 1
                queue.append((nx, ny))
            }
        }
    }
    
    return graph[n - 1][m - 1]
}

// BFS를 수행한 결과 출력
print(bfs(x: 0, y: 0)) // 10
