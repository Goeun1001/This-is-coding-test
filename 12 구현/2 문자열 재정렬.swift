import Foundation

// 내 풀이
let n = "AJKDLSI412K4JSJ9D"
var array = n.sorted()
var number = 0

for i in array {
    if i.isNumber {
        number += Int(String(i))!
        array.removeFirst()
    } else {
        break
    }
}

print(String(array) + String(number))
