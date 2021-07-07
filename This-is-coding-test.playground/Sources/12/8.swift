import Foundation

// 내 풀이.. 는 아예 접근방법이 좀 이상해서 포기!
// 책 풀이
import Foundation

func permuteWirth<T>(_ a: [T], _ n: Int, result: inout [[T]]) {
    if n == 0 {
        result.append(a)
        //        print(a)   // display the current permutation
    } else {
        var a = a
        permuteWirth(a, n - 1, result: &result)
        for i in 0..<n {
            a.swapAt(i, n)
            permuteWirth(a, n - 1, result: &result)
            a.swapAt(i, n)
        }
    }
}

func solution(_ n:Int, _ weak:[Int], _ dist:[Int]) -> Int {
    var newWeak = [Int]()
    // 길이를 2배로 늘려서 '원형'을 일자 형태로 변형
    let length = weak.count
    weak.map { newWeak.append($0) }
    for i in 0...length - 1 {
        newWeak.append(weak[i] + n)
    }
    print(newWeak)
    var answer = dist.count + 1 // 투입할 친구 수의 최솟값을 찾아야 하므로 len(dist) + 1로 초기화
    
    // 0부터 length - 1까지의 위치를 각각 시작점으로 설정
    for start in 0...length - 1 {
        //  친구를 나열하는 모든 경우 각각에 대하여 확인
        var result = [[Int]]()
        permuteWirth(dist, dist.count - 1, result: &result)
        for friends in result {
            var count = 1 // 투입할 친구의 수
            // 해당 친구가 점검할 수 있는 마지막 위치
            var position = newWeak[start] + friends[count - 1]
            // 시작점부터 모든 취약한 지점을 확인
            for index in start...start + length - 1 {
                // 점검할 수 있는 위치를 벗어나는 경우
                if position < newWeak[index] {
                    count += 1 // 새로운 친구를 투입
                    if count > dist.count { // 더 투입이 불가능하다면 종료
                        break
                    }
                    position = newWeak[index] + friends[count - 1]
                }
            }
            answer = min(answer, count) // 최솟값 계산
        }
    }
    
    if answer > dist.count {
        return -1
    }
    
    return answer
}

print(solution(12, [1, 5, 6, 10], [1, 2, 3, 4])) // 2
print(solution(12, [1, 3, 4, 9, 10], [3, 5, 7])) // 1
