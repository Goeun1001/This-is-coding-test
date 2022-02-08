import Foundation

//실패율
//스테이지에 도달했으나 아직 클리어하지 못한 플레이어의 수 / 스테이지에 도달한 플레이어 수

// 전체 스테이지의 개수 N, 게임을 이용하는 사용자가 현재 멈춰있는 스테이지의 번호가 담긴 배열 stages
// 실패율이 높은 스테이지부터 내림차순으로 스테이지의 번호가 담겨있는 배열을 return

func solution(_ N:Int, _ stages:[Int]) -> [Int] {
    let stages = stages.sorted()
    var failed = [[Double]]()
    var players = stages.count

    for i in 1...N {
        var count = 0
        
        for j in stages {
            if i == j {
                count += 1
            } else if i < j {
                break
            }
        }
        
        if count == 0 {
            failed.append([Double(i), 0.0])
        } else {
            failed.append([Double(i), Double(count) / Double(players)])
            players -= count
        }
    }

    return failed.sorted(by: { $0[1] > $1[1] }).map { Int($0.first!) }
}

print(solution(5, [2, 1, 2, 6, 2, 4, 3, 3])) // [3,4,2,1,5]
print(solution(4, [4,4,4,4,4])) // [4,1,2,3]
//print(solution(5, [2,1,2,4,2,4,3,3]))
