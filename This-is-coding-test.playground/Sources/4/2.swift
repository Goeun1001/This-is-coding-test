import Foundation

// 실패한 내 풀이
let h = 5
// 1. 시간에 3이 포함되는 경우의 수 (String)
// 2. 분에 3이 포함되는 경우의 수 (String)

var hour = 0
var minute = 0

for i in 1...h {
    if String(i).contains(Character("3")) { hour += 1 }
}

for i in 1...60 {
    if String(i).contains(Character("3")) { minute += 1 }
}

print(hour)
print(minute)

// 총 경우의 수를 못구하겠어서 실패!
//let result = minute * minute * h * hour
//print(result)

// 책 풀이

var count = 0
for i in 0...h {
    for j in 0...59 {
        for k in 0...59 {
            // 매 시각 안에 '3'이 포함되어 있다면 카운트 증가
            if String(i).contains("3") || String(j).contains("3") || String(k).contains("3") {
                count += 1
            }
        }
    }
}
print(count)
