import Foundation

// 내 풀이
let n = 5
var array = [2, 3, 1, 2, 2]
var count = 0

array.sort()

while !array.isEmpty {
    let max = array.removeLast()

    for _ in 0...max - 2 {
        if !array.isEmpty {
            array.removeFirst()
        } else {
            break
        }
    }
    count += 1
}

print(count)

// 책 풀이가 좀 더 안전한듯? 담부터는 현재 그룹에 포함된 수를 세가면서 좀 더 안전하게 코드 짜도 괜찮을듯.
array = [2, 3, 1, 2, 2]
array.sort()

var result = 0 // 총 그룹의 수
count = 0 // 현재 그룹에 포함된 모험가의 수

for i in array { // 공포도를 낮은 것부터 하나씩 확인하며
    count += 1 // 현재 그룹에 해당 모험가를 포함시키기
    if count >= i { //현재 그룹에 포함된 모험가의 수가 현재의 공포도 이상이라면, 그룹 결성
        result += 1 // 총 그룹의 수 증가시키기
        count = 0 // 현재 그룹에 포함된 모험가의 수 초기화
    }
}

print(result) // 총 그룹의 수 출력
