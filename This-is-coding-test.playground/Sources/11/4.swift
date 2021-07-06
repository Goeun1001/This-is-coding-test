import Foundation

// 내 풀이.. 또 없다
// 책 풀이
let n = 5
var data = [3, 2, 1, 1, 9]
data.sort()

var target = 1
for x in data {
    // 만들 수 없는 금액을 찾았을 때 반복 종료
    if target < x {
        break
    }
    target += x // 이걸 생각을 못해서 틀린듯.. ㅠㅠ
}
// 만들 수 없는 금액 출력
print(target)

