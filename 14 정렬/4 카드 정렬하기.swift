import Foundation

let N = Int(readLine()!)!
var array = [Int]()

for _ in 0..<N {
    array.append(Int(readLine()!)!)
}

array.sort(by: >)

func insert(_ target: Int) {
    var (low, high) = (0, array.count)

    while low < high {
        let mid = (low + high) / 2
        
        if array[mid] <= target {
            high = mid
        } else {
            low = mid + 1
        }
    }
    
    array.insert(target,at: high)
}

var result = 0

while array.count >= 2 {
    let first = array.removeLast()
    let second = array.removeLast()
    
    result += first + second
    
    if array.count > 0 {
        insert(first + second)
//        array.append(first + second)
//        array.sort(by: >)
    }
}

print(result)
