import Foundation

public class BinaryNode<Element> {
    public var value: Element
    public var leftChild: BinaryNode?
    public var rightChild: BinaryNode?
    
    public init(value: Element) {
        self.value = value
    }
}

extension BinaryNode {
    public func traverseInOrder(visit: (Element) -> Void) {
        leftChild?.traverseInOrder(visit: visit)
        visit(value)
        rightChild?.traverseInOrder(visit: visit)
    }
    
    public func traversePreOrder(visit: (Element) -> Void) {
        visit(value)
        leftChild?.traversePreOrder(visit: visit)
        rightChild?.traversePreOrder(visit: visit)
    }
    
    public func traversePostOrder(visit: (Element) -> Void) {
        leftChild?.traversePostOrder(visit: visit)
        rightChild?.traversePostOrder(visit: visit)
        visit(value)
    }
}

extension BinaryNode {
    public func height<T>(node: BinaryNode<T>?) -> Int {
        guard node != nil else { return -1 }
        return 1 + max(height(node: tree.leftChild), height(node: tree.rightChild))
    }
}

extension BinaryNode {
    public func traversePreOrder2(visit: (Element?) -> Void) {
        visit(value)
        if let leftChild = leftChild {
            leftChild.traversePreOrder(visit: visit)
        } else {
            visit(nil)
        }
        if let rightChild = rightChild {
            rightChild.traversePreOrder(visit: visit)
        } else {
            visit(nil)
        }
    }
}

public func serialize<T>(node: BinaryNode<T>) -> [T?] {
    var array: [T?] = []
    node.traversePreOrder2 { array.append($0) }
    return array
}

public func deserialize<T>(array: inout [T?]) -> BinaryNode<T>? {
    guard !array.isEmpty else { return nil }
    guard let value = array.removeFirst() else {
        return nil
    }
    
    let node = BinaryNode(value: value)
    node.leftChild = deserialize(array: &array)
    node.rightChild = deserialize(array: &array)
    return node
}

var tree: BinaryNode<Int> = {
    let zero = BinaryNode(value: 0)
    let one = BinaryNode(value: 1)
    let five = BinaryNode(value: 5)
    let seven = BinaryNode(value: 7)
    
    seven.leftChild = one
    one.leftChild = zero
    one.rightChild = five

    return seven
}()
