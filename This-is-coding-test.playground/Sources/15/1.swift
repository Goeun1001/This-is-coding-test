import Foundation

let n = readLine()!
let array = n.components(separatedBy: " ")
let N = Int(array[0])!
let X = Int(array[1])!

var numbers = [Int]()

let n2 = readLine()!
let arr = n2.components(separatedBy: " ")
for i in arr {
    numbers.append(Int(i)!)
}

var count = numbers.filter { $0 == X }.count

if count == 0 {
    print(-1)
} else {
    print(count)
}
