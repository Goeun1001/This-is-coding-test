import Foundation

let arr = readLine()!.split(separator: " ").map { Int($0)! }
let L = arr[0]
let C = arr[1]

var array = readLine()!.split(separator: " ").map { String($0) }
array.sort()

// 구현해놓은 Combination 연습(Ver 2)
func combi(_ nums: [String], _ targetNum: Int) -> [[String]] {
    var result = [[String]]()
    
    func combination(_ index: Int, _ nowCombi: [String]) {
        if nowCombi.count == targetNum {
            let mo = nowCombi.filter { $0 == "a" || $0 == "e" || $0 == "i" || $0 == "o" || $0 == "u" }
            if mo.count >= 1 && nowCombi.count - mo.count >= 2 {
                result.append(nowCombi)
            }
            return
        }
        
        for i in index..<nums.count {
            if nowCombi.isEmpty || nowCombi.last! < nums[i] {
                combination(i + 1, nowCombi + [nums[i]])
            }
        }
    }
    
    combination(0, [])
    
    return result
}

let result = combi(array, L)

for r in result {
    print(r.joined(separator: ""))
}
