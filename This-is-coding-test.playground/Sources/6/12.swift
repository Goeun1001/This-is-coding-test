import Foundation

let n = 5
let k = 3
var arrayA = [1, 2, 5, 4, 3]
var arrayB = [5, 5, 6, 6, 5]

arrayA.sort() // 배열 A는 오름차순 정렬 수행
arrayB.sort(by: >) // 배열 B는 내림차순 정렬 수행

for i in 0...k - 1 {
    arrayA[i] = arrayB[i]
}

var result = 0
for i in arrayA {
    result += i
}
print(result) // 배열 A의 모든 원소의 합을 출력
