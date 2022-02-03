import Foundation

let array = [8, 3, 7, 9, 2]
let set = Set(array)
let search = [5, 7, 9]

// 손님이 확인 요청한 부품 번호를 하나씩 확인
for i in search {
    // 해당 부품이 존재하는지 확인
    if set.contains(i) {
        print("yes")
    } else {
        print("no")
    }
}
