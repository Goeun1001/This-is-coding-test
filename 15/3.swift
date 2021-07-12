import Foundation

// 책 풀이
// 집의 개수(N)와 공유기의 개수(C)를 입력 받기
let nc = readLine()!
let array = nc.components(separatedBy: " ")
let N = Int(array[0])!
let C = Int(array[1])!

// 전체 집의 좌표 정보를 입력 받기
var tools = [Int]()
for _ in 0...N - 1 {
    tools.append(Int(readLine()!)!) // 공유기 입력
}
tools.sort() // 이진 탐색 수행을 위해 정렬 수행
var start = 1 // 가능한 최소 거리(min gap)
var end = tools[tools.count - 1] - tools[0] // 가능한 최대 거리(max gap)
var result = 0

while start <= end {
    let mid = (start + end) / 2 // mid는 가장 인접한 두 공유기 사이의 거리(gap)을 의미
    // 첫째 집에는 무조건 공유기를 설치한다고 가정
    var value = tools[0]
    var count = 1
    // 현재의 mid 값을 이용해 공유기를 설치하기
    for i in 1...N - 1 { // 앞에서부터 차근차근 설치
        if tools[i] >= value + mid {
            value = tools[i]
            count += 1
        }
    }
    if count >= C { // C개 이상의 공유기를 설치할 수 있는 경우, 거리를 증가시키기
        start = mid + 1
        result = mid // 최적의 결과를 저장
    } else { // C개 이상의 공유기를 설치할 수 없는 경우, 거리를 감소시키기
        end = mid - 1
    }

}

print(result)
