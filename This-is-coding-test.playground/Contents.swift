import Foundation

//실패율
//스테이지에 도달했으나 아직 클리어하지 못한 플레이어의 수 / 스테이지에 도달한 플레이어 수

// 전체 스테이지의 개수 N, 게임을 이용하는 사용자가 현재 멈춰있는 스테이지의 번호가 담긴 배열 stages
// 실패율이 높은 스테이지부터 내림차순으로 스테이지의 번호가 담겨있는 배열을 return

func solution(_ N:Int, _ stages:[Int]) -> [Int] {
    var stages = stages
    stages.sort()
    
    var failed = [Int: Double]()
    var result = [Int]()
    
    for i in 1...N {
        var count = 0
        let length = stages.count
        inner: for j in stages {
            if i == j {
                count += 1
                stages.removeFirst()
            } else if i < j {
                break inner
            }
        }
        if count == 0 {
            failed[i] = 0
        } else {
            failed[i] = Double(Double(count) / Double(length))
        }
    }
    
    for i in failed.sorted(by: { if $0.value == $1.value {
        return $0.key < $1.key
    } else {
        return $0.value > $1.value
    }}) {
        result.append(i.key)
    }
    
    return result
}
//
//print(solution(5, [2, 1, 2, 6, 2, 4, 3, 3])) // [3,4,2,1,5]
//print(solution(5, [4,4,4,4,4])) // [4,1,2,3]
//print(solution(5, [2,1,2,4,2,4,3,3]))

// 다른 사람 풀이
func solution2(_ N:Int, _ stages:[Int]) -> [Int] {

    var failure: [Int: Float] = [:]
    var player: Int = stages.count

    for i in 1...N {
        let n = stages.filter { $0 == i }.count
        failure[i] = Float(n)/Float(player)
        player -= n
    }

    return failure.sorted(by: <).sorted(by: { $0.value > $1.value }).map { $0.key }
}

print(solution2(5, [2, 1, 2, 6, 2, 4, 3, 3])) // [3,4,2,1,5]
print(solution2(5, [4,4,4,4,4])) // [4,1,2,3,5]
print(solution2(5, [2,1,2,4,2,4,3,3]))
