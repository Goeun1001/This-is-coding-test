import Foundation

// 모든 원소의 값이 0보다 크거나 같다고 가정
var array = [7, 5, 9, 0, 3, 1, 6, 2, 9, 1, 4, 8, 0, 5, 2]
//# 모든 범위를 포함하는 리스트 선언 (모든 값은 0으로 초기화)
var count = Array(repeating: 0, count: array.max()! + 1)

for i in 0...array.count - 1 {
    count[array[i]] += 1 // 각 데이터에 해당하는 인덱스의 값 증가
}

for i in 0...count.count - 1 { // 리스트에 기록된 정렬 정보 확인
    if count[i] > 0 {
        for _ in 1...count[i] {
            print(i, separator: " ", terminator: " ") // 띄어쓰기를 구분으로 등장한 횟수만큼 인덱스 출력
        }
    }
}
