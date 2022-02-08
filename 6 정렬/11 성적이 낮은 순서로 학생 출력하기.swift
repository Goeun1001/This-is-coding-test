import Foundation

let n = 2
var array = [["홍길동", 95], ["이순신", 77]]

array.sort {
    let a = $0.last! as! Int
    let b = $1.last! as! Int
    return a < b
}

// 정렬이 수행된 결과를 출력
for i in array {
    print(i.last!, separator: " ", terminator: " ")
}
