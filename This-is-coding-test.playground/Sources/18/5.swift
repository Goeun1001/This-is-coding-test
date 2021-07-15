import Foundation

// 책 풀이.. 위상정렬인줄 생각도 못햇다
// 테스트 케이스(Test Case)만큼 반복
let tc = Int(readLine()!)!

for _ in 1...tc {
    let n = Int(readLine()!)!
    var indegree = Array(repeating: 0, count: n + 1)
    var graph = Array(repeating: Array(repeating: false, count: n + 1), count: n + 1)
    
    // 작년 순위 정보 입력
    let data = readLine()!.components(separatedBy: " ").map { Int($0)! }
    
    // 방향 그래프의 간선 정보 초기화
    for i in 0...n - 2 {
        for j in i + 1...n - 1 {
            graph[data[i]][data[j]] = true
            indegree[data[j]] += 1
        }
    }
    
    // 올해 변경된 순위 정보 입력
    let m = Int(readLine()!)!
    if m != 0 {
        for _ in 1...m {
            let array = readLine()!.components(separatedBy: " ").map { Int($0)! }
            let a = array[0]
            let b = array[1]
            
            // 간선의 방향 뒤집기
            if graph[a][b] {
                graph[a][b] = false
                graph[b][a] = true
                indegree[a] += 1
                indegree[b] -= 1
            } else {
                graph[a][b] = true
                graph[b][a] = false
                indegree[a] -= 1
                indegree[b] += 1
            }
        }
    }
    
    // 위상 정렬(Topology Sort) 시작
    var result = [Int]() // 알고리즘 수행 결과를 담을 리스트
    var q = [Int]()
    
    // 처음 시작할 때는 진입차수가 0인 노드를 큐에 삽입
    for i in 1...n {
        if indegree[i] == 0 {
            q.append(i)
        }
    }
    
    var certain = true // 위상 정렬 결과가 오직 하나인지의 여부
    var cycle = false // 그래프 내 사이클이 존재하는지 여부
    
    // 정확히 노드의 개수만큼 반복
    for _ in 1...n {
        // 큐가 비어 있다면 사이클이 발생했다는 의미
        if q.count == 0 {
            cycle = true
            break
        }
        // 큐의 원소가 2개 이상이라면 가능한 정렬 결과가 여러 개라는 의미
        if q.count >= 2 {
            certain = false
            break
        }
        
        let now = q.removeFirst()
        result.append(now)
        
        // 해당 원소와 연결된 노드들의 진입차수에서 1 빼기
        for j in 1...n {
            if graph[now][j] {
                indegree[j] -= 1
                // 새롭게 진입차수가 0이 되는 노드를 큐에 삽입
                if indegree[j] == 0 {
                    q.append(j)
                }
            }
        }
    }
    
    // 사이클이 발생하는 경우(일관성이 없는 경우)
    if cycle {
        print("IMPOSSIBLE")
    } else if !certain { // 위상 정렬 결과가 여러 개인 경우
        print("?")
    } else { // 위상 정렬을 수행한 결과 출력
        for i in result {
            print(i, terminator: " ")
        }
        print()
    }
}
