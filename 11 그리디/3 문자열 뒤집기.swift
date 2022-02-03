import Foundation

// 내 풀이
let str = readLine()!

// 연속된 부분이 더 적은 것을 뒤집으면 됨
func solution(_ str: String) -> Int {
    let array: [Int] = str.map { Int(String($0))! }
    
    var current = -1 // 현재 0인지 1인지 구분
    var zeroCount = 0 // 0의 연속된 부분의 갯수
    var oneCount = 0 // 1의 연속된 부분의 갯수
    
    for i in array {
        if current != i { // 부분이 시작되는 경우
            current = i
            if i == 0 {
                zeroCount += 1
            } else {
                oneCount += 1
            }
        }
    }
    
    return min(zeroCount, oneCount)
}

print(solution(str))

// 책 풀이

let input = "0001100"
let data = Array(input)
var count0 = 0 // 전부 0으로 바꾸는 경우
var count1 = 0 // 전부 1로 바꾸는 경우

// 첫 번째 원소에 대해서 처리
if data[0] == "1" {
    count0 += 1
} else {
    count1 += 1
}
// 두 번째 원소부터 모든 원소를 확인하며
for i in 1...data.count - 2 {
    if data[i] != data[i + 1] {
        // 다음 수에서 1로 바뀌는 경우
        if data[i + 1] == "1" {
            count0 += 1
        } else {
            // 다음 수에서 0으로 바뀌는 경우
            count1 += 1
        }
    }
}

print(min(count0, count1))
