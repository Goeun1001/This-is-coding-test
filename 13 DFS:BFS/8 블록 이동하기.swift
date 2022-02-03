import Foundation

func nextPos(pos: ([Int], [Int]), board: [[Int]]) -> [[[Int]]] {
    var result = [[[Int]]]()
    let n = board.count
    let pos1X = pos.0[0]
    let pos1Y = pos.0[1]
    let pos2X = pos.1[0]
    let pos2Y = pos.1[1]
    
    let dx = [-1, 1, 0, 0]
    let dy = [0, 0, -1, 1] // 상하좌우
    
    for i in 0...3 {
        let pos1NX = pos1X + dx[i]
        let pos1NY = pos1Y + dy[i]
        let pos2NX = pos2X + dx[i]
        let pos2NY = pos2Y + dy[i]
        
        if pos1NX < 0 || pos1NY < 0 || pos2NX < 0 || pos2NY < 0 || pos1NX >= n || pos1NY >= n || pos2NX >= n || pos2NY >= n {
            continue
        }
        
        // 이동하고자 하는 두 칸이 모두 비어 있다면
        if board[pos1NX][pos1NY] == 0 &&
            board[pos2NX][pos2NY] == 0 {
            result.append([[pos1NX, pos1NY], [pos2NX, pos2NY]])
        }
    }
    
    if pos1X == pos2X { // 현재 로봇이 가로로 놓여 있는 경우
        for i in [-1, 1] {
            // 위쪽 혹은 아래쪽 두 칸이 모두 비어 있다면
            if pos1X + i < 0 || pos2X + i < 0 || pos1X + i >= n || pos2X + i >= n {
                continue
            }
            
            if board[pos1X + i][pos1Y] == 0 && board[pos2X + i][pos2Y] == 0 {
                result.append([[pos1X, pos1Y], [pos1X + i, pos1Y]])
                result.append([[pos2X, pos2Y], [pos2X + i, pos2Y]])
            }
        }
    } else if pos1Y == pos2Y {
        for i in [-1, 1] {
            if pos1Y + i < 0 || pos2Y + i < 0 || pos1Y + i >= n || pos2Y + i >= n {
                continue
            }
            
            // 위쪽 혹은 아래쪽 두 칸이 모두 비어 있다면
            if board[pos1X][pos1Y + i] == 0 && board[pos2X ][pos2Y + i] == 0 {
                result.append([[pos1X, pos1Y], [pos1X, pos1Y + i]])
                result.append([[pos2X, pos2Y], [pos2X, pos2Y + i]])
            }
        }
    }
    
    return result
}

func solution(_ board:[[Int]]) -> Int {
    let n = board.count
    var queue = [([0, 0], [0, 1], 0)] // 첫번쨰, 두번쨰, 비용
    var visited = Set<[[Int]]>()
    visited.insert([[0, 0], [0, 1]])
    visited.insert([[0, 1], [0, 0]]) //뒤집어서 꼬옥 넣어줘야함
    
    while !queue.isEmpty {
        let node = queue.removeFirst()
        let position = (node.0, node.1)
        let cost = node.2
        
        // (n, n) 위치에 로봇이 도달했다면, 최단 거리이므로 반환
        if position.0 == [n - 1, n - 1] || position.1 == [n - 1, n - 1] {
            return cost
        }
        
        // 현재 위치에서 이동할 수 있는 위치 확인
        for nextP in nextPos(pos: position, board: board) {
            if !visited.contains(nextP) {
                queue.append((nextP[0], nextP[1], cost + 1))
                visited.insert([nextP[0], nextP[1]])
                visited.insert([nextP[1], nextP[0]])
            }
        }
    }
    
    return 0
}

solution([[0, 0, 0, 1, 1],[0, 0, 0, 1, 0],[0, 1, 0, 1, 1],[1, 1, 0, 0, 1],[0, 0, 0, 0, 0]]) // 7
