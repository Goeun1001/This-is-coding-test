import Foundation

func combi<T>(_ target: [T], _ targetNum: Int) -> [[T]] {
    var result = [[T]]()
    
    func combination(_ index: Int, _ temp: [T]) {
        if temp.count == targetNum {
            result.append(temp)
            return
        }
        
        for i in index..<target.count {
            combination(i + 1, temp + [target[i]])
        }
    }
    
    combination(0, [])
    
    return result
}

print(combi([1, 2, 3], 2))
