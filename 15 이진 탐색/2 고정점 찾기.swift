import Foundation

let n = readLine()!
let array = n.components(separatedBy: " ")
let N = Int(array[0])!

var numbers = [Int]()

let n2 = readLine()!
let arr = n2.components(separatedBy: " ")
for i in arr {
    numbers.append(Int(i)!)
}

var count = -1

for (index, value) in numbers.enumerated() {
    if index == value {
        count = index
        break
    }
}

print(count)
