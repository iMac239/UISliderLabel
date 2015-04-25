// Playground - noun: a place where people can play

import Cocoa

var x: Int = 1
var y = UnsafeMutablePointer<Int>.alloc(x)

y
x = 4

println(y)



var str: String!

if let theStr = Optional(str) {
//    println("\(theStr)")
} else {
    println("nil")
}


