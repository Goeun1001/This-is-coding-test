import Foundation

let array = [[3, 1, 2], [4, 1, 4], [2, 2, 2]]
var result = 0
var min_value = 0

for i in array.indices {
    // 현재 줄에서 '가장 작은 수' 찾기
    min_value = array[i].min()!
    // '가장 작은 수'들 중에서 가장 큰 수 찾기
    result = max(result, min_value)
}
print(result) // 최종 답안 출력
