import Foundation

// 책 풀이
let arr = readLine()!.components(separatedBy: " ").map { Int($0)! }
let n = arr[0]
let m = arr[1]
let k = arr[2]
// 모든 상어의 위치와 방향 정보를 포함하는 2차원 리스트
var array = [[Int]]()

for _ in 1...n {
    array.append(readLine()!.components(separatedBy: " ").map { Int($0)! })
}

// 모든 상어의 현재 방향 정보
var directions = readLine()!.components(separatedBy: " ").map { Int($0)! }

// 각 위치마다 [특정 냄새의 상어 번호, 특정 냄새의 남은 시간]을 저장하는 2차원 리스트
var smell = Array(repeating: Array(repeating: (0, 0), count: n), count: n)
// 각 상어의 회전 우선순위 정보
var priorities = Array(repeating: [[Int]](), count: m)

for i in 0...m - 1 {
    for _ in 0...3 {
        priorities[i].append(readLine()!.components(separatedBy: " ").map { Int($0)! })
    }
}

// 특정 위치에서 이동 가능한 4가지 방향
let dx = [-1, 1, 0, 0]
let dy = [0, 0, -1, 1]

// 모든 냄새 정보를 업데이트
func update_smell() {
    // 각 위치를 하나씩 확인하며
    for i in 0...n - 1 {
        for j in 0...n - 1 {
            // 냄새가 존재하는 경우, 시간을 1만큼 감소시키기
            if smell[i][j].1 > 0 {
                smell[i][j].1 -= 1
            }
            // 상어가 존재하는 해당 위치의 냄새를 k로 설정
            if array[i][j] != 0 {
                smell[i][j] = (array[i][j], k)
            }
        }
    }
}

// 모든 상어를 이동시키는 함수
func move() -> [[Int]] {
    // 이동 결과를 담기 위한 임시 결과 테이블 초기화
    var new_array = Array(repeating: Array(repeating: 0, count: n), count: n)
    // 각 위치를 하나씩 확인하며
    for x in 0...n - 1 {
        for y in 0...n - 1 {
            // 상어가 존재하는 경우
            if array[x][y] != 0 {
                let direction = directions[array[x][y] - 1] // 현재 상어의 방향
                var found = false
                
                // 일단 냄새가 존재하지 않는 곳이 있는지 확인
                for index in 0...3 {
                    let nx = x + dx[priorities[array[x][y] - 1][direction - 1][index] - 1]
                    let ny = y + dy[priorities[array[x][y] - 1][direction - 1][index] - 1]
                    if 0 <= nx && nx < n && 0 <= ny && ny < n {
                        if smell[nx][ny].1 == 0 { // 냄새가 존재하지 않는 곳이면
                            // 해당 상어의 방향 이동시키기
                            directions[array[x][y] - 1] = priorities[array[x][y] - 1][direction - 1][index]
                            //  상어 이동시키기 (만약 이미 다른 상어가 있다면 번호가 낮은 것이 들어가도록)
                            if new_array[nx][ny] == 0 {
                                new_array[nx][ny] = array[x][y]
                            } else {
                                new_array[nx][ny] = min(new_array[nx][ny], array[x][y])
                            }
                            found = true
                            break
                        }
                    }
                }
                
                if found {
                    continue
                }
                // 주변에 모두 냄새가 남아 있다면, 자신의 냄새가 있는 곳으로 이동
                for index in 0...3 {
                    let nx = x + dx[priorities[array[x][y] - 1][direction - 1][index] - 1]
                    let ny = y + dy[priorities[array[x][y] - 1][direction - 1][index] - 1]
                    if 0 <= nx && nx < n && 0 <= ny && ny < n {
                        if smell[nx][ny].0 == array[x][y] { // 자신의 냄새가 있는 곳이면
                            // 해당 상어의 방향 이동시키기
                            directions[array[x][y] - 1] = priorities[array[x][y] - 1][direction - 1][index]
                            // 상어 이동시키기
                            new_array[nx][ny] = array[x][y]
                            break
                        }
                    }
                }
            }
        }
    }
    return new_array
}

var time = 0
while true {
    update_smell() // 모든 위치의 냄새를 업데이트
    let new_array = move() // 모든 상어를 이동시키기
    array = new_array // 맵 업데이트
    time += 1 // 시간 증가
    
    // 1번 상어만 남았는지 체크
    var check = true
    for i in 0...n - 1 {
        for j in 0...n - 1 {
            if array[i][j] > 1 {
                check = false
            }
        }
    }
    
    if check {
        print(time)
        break
    }
    
    // 1000초가 지날 때까지 끝나지 않았다면
    if time >= 1000 {
        print(-1)
        break
    }
}
