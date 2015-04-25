//
//  ViewController.swift
//  Demo
//
//  Created by Ian MacCallum on 3/26/15.
//
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var sliderLabel: UISliderLabel!
    var foo: CGFloat = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        var str: String! = nil
        
        if let theStr = Optional(str) {
            //    println("\(theStr)")
        } else {
            println("nil")
        }

        
        sliderLabel.delegate = self
    }
}

extension ViewController: UISliderLabelDelegate {
    func sliderLabel(sliderLabel: UISliderLabel, didChangeValue value: CGFloat) {
//        println("value changed to \(value)")
        self.foo = value
    }
    
    func sliderLabel(sliderLabel: UISliderLabel, formatForValue value: CGFloat) -> String? {
        return "#\(Int(foo))"
    }
    
    func sliderLabel(defaultValueForSliderLabel sliderLabel: UISliderLabel) -> CGFloat? {
        return foo
    }
    
    func sliderLabel(minValueForSliderLabel sliderLabel: UISliderLabel) -> CGFloat? {
        return 0
    }
    
    func sliderLabel(maxValueForSliderLabel sliderLabel: UISliderLabel) -> CGFloat? {
        return 1000
    }
    
    func sliderLabel(deviationValueForSliderLabel sliderLabel: UISliderLabel) -> CGFloat? {
        return 10
    }
    
    func sliderLabel(incrementByValueForSliderLabel sliderLabel: UISliderLabel) -> CGFloat? {
        return 1
    }
}
