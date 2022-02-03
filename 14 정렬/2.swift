import Foundation

// 책 풀이 참고 ㅠㅠ
let number = Int(readLine()!)!
var houses = [Int]()
let house = readLine()!
let array = house.components(separatedBy: " ")
array.map { houses.append(Int($0)!) }
houses.sort()

print(houses[(number - 1) / 2])
