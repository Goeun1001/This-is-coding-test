import Foundation

// 배열에 10,000개의 정수를 삽입
var array = [Int]()
for _ in 0...10000 {
    // 1부터 100 사이의 랜덤한 정수
    array.append(Int.random(in: 1...100))
}

// 선택 정렬 프로그램 성능 측정
var start = Date()

// 선택 정렬 프로그램 소스코드
for i in 0..<array.count {
    var minIndex = i // 가장 작은 원소의 인덱스
    for j in i+1..<array.count {
        if array[minIndex] > array[j] {
            minIndex = j
        }
    }
    array.swapAt(i, minIndex) // 스왑
}

var end =  Date() // 측정 종료
print("선택 정렬 성능 측정:", end.timeIntervalSince(start)) // 수행 시간 출력

// 배열을 다시 무작위 데이터로 초기화
array = [Int]()
for _ in 0...10000 {
    // 1부터 100 사이의 랜덤한 정수
    array.append(Int.random(in: 1...100))
}

start = Date() // 기본 정렬 라이브러리 성능 측정

array.sort()

end =  Date() // 측정 종료
print("기본 정렬 라이브러리 성능 측정:", end.timeIntervalSince(start)) // 수행 시간 출력
