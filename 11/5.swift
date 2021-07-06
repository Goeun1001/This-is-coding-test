import Foundation

// 내 풀이
var n = 5
let max = 3
var array = [1, 3, 2, 3, 2] // -> [1, 2, 2]로 만들고 처음부터 끝가지 곱하면 됨

var countArray = Array(repeating: 0, count: max + 1)

for a in array {
    countArray[a] += 1 // [0, 1, 2, 2]인 countArray 만들기
}

var result = 0

for i in 1...max {
    var count = 0
    if countArray[i] != 0 { // 혹시 0일까봐.. ㅎㅎ
        for j in i...max { // 현재 위치 다음부터의 수를 더한다.
            if i != j {
                count += countArray[j]
            }
        }
    }
    if count != 0 { // 현재위치부터 끝까지의 수를 더해서 곱하는 거.
        result += countArray[i] * count
    }
}

print(result)

// 책 풀이
result = 0

// 1부터 max까지의 각 무게에 대하여 처리
for i in 1...max {
    // 어떻게.. n에 마이너스할 생각을.. ;;
    n -= countArray[i] // 무게가 i인 볼링공의 개수(A가 선택할 수 있는 개수) 제외
    result += countArray[i] * n // B가 선택하는 경우의 수와 곱해주기
}
print(result)
