import Foundation

// 내 풀이 정답~~~!!!
func remove(target: [Int], result: [[Int]]) -> [[Int]] {
    var removeIndex = 0
    for i in 0...result.count - 1 { // 일단 배열에서 지워본 후 check 함수 적용
        if result[i] == target {
            removeIndex = i
            break
        }
    }
    for value in result {
        if value[2] == 0 {
            var r = result
            r.remove(at: removeIndex)
            if !check_gi(xy: [value[0], value[1]], result: &r) {
                print("기둥이 안세워지네요")
                return result
            }
        } else {
            var r = result
            r.remove(at: removeIndex)
            if !check_bo(xy: [value[0], value[1]], result: &r) {
                print("보가 안세워지네요")
                return result
            }
        }
    }
    var r = result
    r.remove(at: removeIndex)
    return r
}

@discardableResult
func check_bo(xy: [Int], result: inout [[Int]]) -> Bool {
    // 보는 한쪽 끝 부분이 기둥 위에 있거나, 또는 양쪽 끝 부분이 다른 보와 동시에 연결되어 있어야 합니다.
    let x = xy.first!
    let y = xy.last!
    var concurrent = 0

    for i in result {
        if i == [x, y - 1, 0] || i == [x + 1, y - 1, 0] { // 한쪽 끝 부분이 기둥 위에 있으면
            result.append([x, y, 1])
            return true
        }
        // 양쪽 끝 부분이 다른 보와 동시에 연결되어 있다면
        if i == [x - 1, y, 1] {
            concurrent += 1
        }
        if i == [x + 1, y, 1] {
            concurrent += 1
        }
    }
    
    if concurrent == 2 {
        result.append([x, y, 1])
        return true
    }
    return false
}

@discardableResult
func check_gi(xy: [Int], result: inout [[Int]]) -> Bool {
    // 기둥은 바닥 위에 있거나 보의 한쪽 끝 부분 위에 있거나, 또는 다른 기둥 위에 있어야 합니다.
    let x = xy.first!
    let y = xy.last!

    if y == 0 { // 기둥이 바닥 위에 있으면
        result.append([x, y, 0])
        return true
    }

    for i in result {
        if i == [x - 1, y, 1] { // 설치할 기둥 밑에 보가 있으면
            result.append([x, y, 0])
            return true
        }
        if i == [x, y, 1] { // 설치할 기둥 밑에 보가 있으면
            result.append([x, y, 0])
            return true
        }
        if i == [x, y - 1, 0] { // 설치할 기둥 밑에 다른 기둥이 있으면
            result.append([x, y, 0])
            return true
        }
    }
    return false
}

func solution(_ n:Int, _ build_frame:[[Int]]) -> [[Int]] {
    var queue = build_frame
    var result = [[Int]]()

    while !queue.isEmpty {
        let value = queue.removeFirst()
        if value.last! == 1 {
            if value[2] == 0 {
                check_gi(xy: [value[0], value[1]], result: &result)
            } else {
                check_bo(xy: [value[0], value[1]], result: &result)
            }
        }
        else {
            result = remove(target: [value[0], value[1], value[2]], result: result)
        }
    }
    result.sort(by: {
        if $0.first! == $1.first! {
            if $0[1] == $1[1] {
                return $0[2] < $1[2]
            } else {
                return $0[1] < $1[1]
            }
        } else {
            return $0.first! < $1.first!
        }
    })
    return result
}

print(solution(5, [[1,0,0,1],[1,1,1,1],[2,1,0,1],[2,2,1,1],[5,0,0,1],[5,1,0,1],[4,2,1,1],[3,2,1,1]]))
// [[1,0,0],[1,1,1],[2,1,0],[2,2,1],[3,2,1],[4,2,1],[5,0,0],[5,1,0]]
print(solution(5, [[0,0,0,1],[2,0,0,1],[4,0,0,1],[0,1,1,1],[1,1,1,1],[2,1,1,1],[3,1,1,1],[2,0,0,0],[1,1,1,0],[2,2,0,1]]))
// [[0,0,0],[0,1,1],[1,1,1],[2,1,1],[3,1,1],[4,0,0]]
