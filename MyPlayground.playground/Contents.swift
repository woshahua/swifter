import UIKit


// currying
func addTo(_ adder: Int)->(Int)->Int{
    return {
        num in
        return num + adder
    }
}

var addTwo = addTo(2)
addTwo(10)

// protocol mutating

protocol Vehicle {
    var numberOfWheels: Int {get}
    var color: UIColor {get set}
    mutating func changeColor(color: UIColor)
}

struct Car: Vehicle {
    let numberOfWheels = 4
    var color = UIColor.red
    mutating func changeColor(color: UIColor){
        self.color = color
    }
}

// inherit protocol IteratorProtocol to use for ... in
class ReverseIterator<T>: IteratorProtocol{
    typealias Element = T
    
    var array: [Element]
    var currentIndex = 0
    
    init(array: [Element]){
        self.array = array
        currentIndex = array.count - 1
    }
    
    // the next one maybe nil, think about if we dont have this optional how to do
    func next() -> Element?{
        if currentIndex < 0{
            return nil
        }
        else{
            let element = array[currentIndex]
            currentIndex -= 1
            return element
        }
    }
}

// inherit from a ReverseSequence here
struct ReverseSequence<T>: Sequence{
    var array: [T]
    
    init(array: [T]){
        self.array = array
    }
    typealias Iterator = ReverseIterator<T>
    
    func makeIterator() -> ReverseIterator<T> {
        return ReverseIterator(array: self.array)
    }
}

let arr = [0, 1, 2, 3, 4]

for i in ReverseSequence(array: arr){
    print("Index \(i) is \(arr[i])")
}

// @autoclosure
func logIfTrue(_ predicate: () -> Bool){
    if predicate(){
        print("True")
    }
}

logIfTrue({return 2 > 1})
// simpler
logIfTrue({2>1})
logIfTrue{2>1}

// use @autoclosure
func logIfTrue(_ predicate: @autoclosure () -> Bool) {
    if predicate(){
        print("True")
    }
}

logIfTrue(2 > 1)

// judge nil
var level: Int?
var startLevel = 1

var currentLevel = level ?? startLevel

// @escaping
func doWork(block: ()->()) {
    block()
}

func doWorkAsync(block: @escaping ()->()) {
    DispatchQueue.main.async {
        block()
    }
}

// optional chaining

// func 修饰
//func incrementor(variable: Int)->Int {
//    return variable + 1
//}
// 没有修饰符的，默认为let
func incrementor(variable: Int) -> Int{
    return variable
}

// _ in function parameter
//func addElement(ball target: String){
//    print(target)
//}
//
//addElement(ball: "lil ball")

// so its like: variableName type: RealType
// you can do this, _ type: RealType
// why ???
func addElement(ball: String){
    print(ball)
}

addElement(ball: "lil")

// 单例
class SingleTon{
    static let shared = SingleTon()
    private init(){}
}

import Foundation

// 结构体是传递值，class是传递引用

struct Point{
    var x = 10
    var y = 10
}

var a = Point()
print(a)
var b = a
b.x += 10
print(b)
print(a)

class PointClass{
    var x = 10
    var y = 10
}

let ac = PointClass()
print(ac)
let bc = ac
bc.x += 10
print(ac.x)
print(bc.x)

// didset
struct TestDidSet{
    var age = 10{
        willSet{
            print("\(age) is, new value is \(newValue)" )
        }
        didSet{
            print("\(oldValue) is, new value is \(age)" )
        }
    }
}

var t = TestDidSet()
t.age = 100

class A{
    var b: B?
    deinit {
        print("A released")
    }
}

class B{
    weak var a: A?
    deinit {
        print("B released")
    }
}

var aclos: A? = A()
var bclos: B? = B()
aclos?.b = bclos
bclos?.a = aclos

aclos = nil
//bclos = nil

var aStr: String?

// list is value in swift so
var xlist = [1, 2, 3]
var ylist = xlist
xlist.append(5)
// ylist wont change
ylist


// 重载
func logger<View: UIView>(_ view: View){
    print("it's \(type(of: view)), frame:\(view.frame)")
}

func logger(_ view: UILabel){
    let text = view.text ?? "(empty)"
    print("it's UILabel, text is \(text)")
}

let label = UILabel(frame: CGRect(x: 10, y: 10, width: 10, height: 10))
logger(label)

let button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
logger(button)

// currying
func addTo2(_ adder: Int)-> (Int) -> Int {
    return {
        num in
        return num + adder
    }
}

var addTo22 = addTo2(2)
addTo22(10)
// a function need a return value is for this curryig
// for currying this is simply, return a function.
// and return a function in closure

// test map
var sequence: [Int] = [1,2,3,4,5,6]
// can we set a list that has diffrent type of element
var sequenceM: [Any?] = [1, "a", 3, "b", nil] // need to set type as any or not

sequence = sequence.map{seq in seq*seq}
sequence
// map can follow with a closure function
// 
