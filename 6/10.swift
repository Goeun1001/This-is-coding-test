import Foundation

let n = 3
var array = [15, 27, 12]
// 스위프트 정렬 라이브러리를 이용하여 내림차순 정렬 수행
array.sort(by: >)
for i in array {
    print(i, separator: " ", terminator: " ")
}