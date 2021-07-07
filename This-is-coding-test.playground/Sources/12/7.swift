import Foundation

// 내 풀이
let n = 5
var m = 3
let array = [[0, 0, 1, 0, 0], [0, 0, 2, 0, 1], [0, 1, 2, 0, 0], [0, 0, 1, 0, 0], [0, 0, 0, 0, 2]]
//let n = 5
//var m = 2
//let array = [[0, 2, 0, 1, 0], [1, 0, 1, 0, 0], [0, 0, 0, 0, 0], [2, 0, 0, 1, 1], [2, 2, 0, 1, 2]]

var house = [[Int]]() // [x, y]
var shop = [[Int]]() // [[x, y] : 1] 짧은 치킨거리의 카운트
var shopCount = [[Int]: Int]()

for i in 0...array.count - 1 { // house, shop 좌표 세팅
    for j in 0...array[i].count - 1 {
        if array[i][j] == 1 {
            house.append([i, j])
        }
        if array[i][j] == 2 {
            shop.append([i, j])
            shopCount.updateValue(0, forKey: [i, j])
        }
    }
}

for i in house {
    var value = 10000
    var minShop = [Int]() // [x, y] 치킨거리가 가장 짧은 가게.
    for shop in shop { // 가장 짧은 치킨집
        if abs(i[0] - shop[0]) + abs(i[1] - shop[1]) < value {
            minShop = shop
            value = abs(i[0] - shop[0]) + abs(i[1] - shop[1])
        }
    }
    if shopCount[minShop] != nil { // 카웅ㄴ트 증가
        shopCount[minShop]! += 1
    } else {
        shopCount[minShop] = 1
    }
}

var newShop = [[Int]]() // 걸러진 치킨집의 좌표들. [x, y]

for i in shopCount.sorted(by: { $0.value > $1.value }) {
    if m > 0 {
        newShop.append(i.key)
        m -= 1
    } else {
        break
    }
}

print(newShop)
var result = 0

for i in house {
    var value = 10000
    for shop in newShop { // M개의 치킨집의 거리 총합
        value = min(value, abs(i[0] - shop[0]) + abs(i[1] - shop[1]))
    }
    print(i, value)
    result += value
}

print(result)
